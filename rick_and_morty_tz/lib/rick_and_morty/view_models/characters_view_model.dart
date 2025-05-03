import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_tz/rick_and_morty/models/character.dart';
import 'package:rick_and_morty_tz/rick_and_morty/models/user_error.dart';
import 'package:rick_and_morty_tz/rick_and_morty/repo/api/api_status.dart';
import 'package:rick_and_morty_tz/rick_and_morty/repo/api/character_service.dart';
import 'package:rick_and_morty_tz/rick_and_morty/repo/local/local_database.dart';
import 'package:rick_and_morty_tz/utils/constants.dart';
import 'package:rick_and_morty_tz/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CharactersViewModel extends ChangeNotifier {
  bool _loading = false;
  int _page = 1;
  bool _hasMore = true;

  final List<Character> _characterListModel = [];
  final List<Character> _favouriteCharacters = [];
  FavouriteSortType _sortType = FavouriteSortType.az;
  UserError? _userError;

  bool get loading => _loading;
  bool get hasMore => _hasMore;
  int get page => _page;
  List<Character> get characterListModel => _characterListModel;
  List<Character> get favouriteCharacters => _favouriteCharacters;
  FavouriteSortType get sortType => _sortType;
  UserError? get userError => _userError;
  

  CharactersViewModel() {
    _loadCachedData().then((_) async {
      await _loadFavourites();

      if (_characterListModel.isNotEmpty) {
        int maxPage = 1;

        for (final character in _characterListModel) {
          final page = character.page ?? 1;
          if (page > maxPage) {
            maxPage = page;
          }
        }
        _page = maxPage + 1;
      }
      loadMoreCharacters();
    });
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void _setHasMorePages(bool hasMore) {
    _hasMore = hasMore;
  }  

  void _setUserError(UserError? error) {
    _userError = error;
  }

  Future<void> _loadCachedData() async {
    try {
      final cachedCharacters = await LocalDatabase().loadCharacters();
      if (cachedCharacters.isNotEmpty) {
        _characterListModel.clear();
        _characterListModel.addAll(cachedCharacters);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Ошибка загрузки кэша: $e");
      }
    }
  }
  
  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Future<void> loadMoreCharacters() async {
    if (_loading || !_hasMore) return;
    _setLoading(true);

    bool isConnected = await _checkInternetConnection();

    if (isConnected) {
      var response = await CharacterService.getCharacters(page: _page);

      if (response is Success) {
        final newCharacters = response.response as List<Character>;
        if (newCharacters.isEmpty) {
          _setHasMorePages(false);
        } else {
          _characterListModel.addAll(newCharacters);
          await LocalDatabase().saveCharacters(newCharacters, _page);
          _page++; // Готовимся к следующему запросу
        }
        _setUserError(null);
      } else if (response is Failure) {
        if (response.code == USER_INVALID_RESPONSE && _page > 1) {
          _setHasMorePages(false);      
        } else {
          _setUserError(
            UserError(
              code: response.code,
              message: response.errorResponse.toString(),
            ),
          );
        }
      }
    } else {
      // Если нет интернета, проверяем кэшированные данные
      if (_characterListModel.isEmpty) {
        List<Character> cachedCharacters =
            await LocalDatabase().loadCharacters();
        if (cachedCharacters.isNotEmpty) {
          _characterListModel.addAll(cachedCharacters);
          _setUserError(null,);
        } else {
          // Если кэш пуст, показываем ошибку
          UserError userError = UserError(
            code: NO_INTERNET,
            message: 'No Internet Connection',
          );
          _setUserError(userError);
        }

      }

      _setHasMorePages(false);
    }

    _setLoading(false);
  }


  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(favouriteKey) ?? [];

    _favouriteCharacters.clear();
    for (var jsonStr in jsonList) {
      final map = jsonDecode(jsonStr);
      _favouriteCharacters.add(Character.fromJson(map));
    }
    sortFavourites(_sortType);
  }

  Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        _favouriteCharacters.map((char) => jsonEncode(char.toJson())).toList();
    await prefs.setStringList(favouriteKey, jsonList);
  }

  Future<bool> addToFavourite(Character favCharacter) async {
    if (_favouriteCharacters.length >= maxFavourites) {
      return false;
    }
    _favouriteCharacters.add(favCharacter);
    sortFavourites(_sortType);
    await _saveFavourites();
    return true;
  }

  Future<void> removeFromFavouriteById(int id) async {
    _favouriteCharacters.removeWhere((character) => character.id == id);
    await _saveFavourites();
    notifyListeners();
  }
  
  void sortFavourites(FavouriteSortType type) {
    _sortType = type;

    _favouriteCharacters.sort((a, b) {
      final nameA = a.name.toLowerCase();
      final nameB = b.name.toLowerCase();
      return type == FavouriteSortType.az
          ? nameA.compareTo(nameB)
          : nameB.compareTo(nameA);
    });

    notifyListeners();
  }

}

