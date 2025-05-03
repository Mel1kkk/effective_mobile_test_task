import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_tz/components/app_state/app_error.dart';
import 'package:rick_and_morty_tz/components/app_state/app_loading.dart';
import 'package:rick_and_morty_tz/components/character_card.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view_models/characters_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
          child: Consumer<CharactersViewModel>(
            builder: (context, charactersViewModel, child) {
              if (charactersViewModel.userError != null) {
                return AppError(
                  errortxt: charactersViewModel.userError!.message,
                );
              }
      
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              final triggerFetchMoreThreshold = 200.0;
              if (!charactersViewModel.loading &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent -
                          triggerFetchMoreThreshold) {
                charactersViewModel.loadMoreCharacters();
              }
              return false;
            },
            child: _buildGrid(charactersViewModel),
          );
        },
      ),
    );
  }


  /// Построение сетки карточек с динамическим количеством колонок в зависимости от доступного пространства.
  Widget _buildGrid(CharactersViewModel charactersViewModel) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Максимальная ширина карточки
              childAspectRatio: 0.7, // Соотношение сторон карточки
              crossAxisSpacing: 10, // Отступы между карточками по горизонтали
              mainAxisSpacing: 10, // Отступы между карточками по вертикали
            ),
            itemCount: charactersViewModel.characterListModel.length,
            itemBuilder: (context, index) {
              // Создаём карточку для каждого персонажа
              return CharacterCard(
                character: charactersViewModel.characterListModel[index],
              );
            },
          ),
        ),
        // Если данные ещё грузятся, выводим индикатор загрузки под списком карточек
        if (charactersViewModel.loading && charactersViewModel.hasMore)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const AppLoading(),
          ),
      ],
    );
  }
}
