import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_tz/rick_and_morty/models/character.dart';
import 'package:rick_and_morty_tz/rick_and_morty/repo/api/api_status.dart';
import 'package:rick_and_morty_tz/utils/constants.dart';

class CharacterService {
  static Future<Object> getCharacters({int page = 1}) async {
    try {
      final url = Uri.parse('$characterEndpoint/?page=$page');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Success(
          code: SUCCESS,
          response: characterListModelFromJson(response.body),
        );

      }

      return Failure(
        code: USER_INVALID_RESPONSE,
        errorResponse: 'Invalid Response',
      );
    } on HttpException {
      return Failure(
        code: NO_INTERNET,
        errorResponse: 'No Internet Connection',
      );
    } on SocketException {
      return Failure(
        code: NO_INTERNET,
        errorResponse: 'No Internet Connection',
      );
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }

  }
}
