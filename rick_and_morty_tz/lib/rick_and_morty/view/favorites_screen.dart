import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_tz/components/character_card.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view_models/characters_view_model.dart';
import 'package:rick_and_morty_tz/utils/enums.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewModel>();
    final favourites = viewModel.favouriteCharacters;    

    if (favourites.isEmpty) {
      return const Center(
        child: Text(
          'Нет избранных персонажей',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          isSelected: [
            viewModel.sortType == FavouriteSortType.az,
            viewModel.sortType == FavouriteSortType.za,
          ],
          onPressed: (index) {
            final type = index == 0 ? FavouriteSortType.az : FavouriteSortType.za;
            context.read<CharactersViewModel>().sortFavourites(type);
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('A → Z'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Z → A'),
            ),
          ],
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: favourites.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return CharacterCard(character: favourites[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

