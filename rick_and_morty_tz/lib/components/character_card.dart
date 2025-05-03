import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_tz/components/bold_title.dart';
import 'package:rick_and_morty_tz/components/cached_image_persistent.dart';
import 'package:rick_and_morty_tz/rick_and_morty/models/character.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view_models/characters_view_model.dart';

class CharacterCard extends StatefulWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  CharacterCardState createState() => CharacterCardState();
}

class CharacterCardState extends State<CharacterCard> {
  bool showFront = true;
  bool toggleFavourite = false;

  void _toggleCard() {
    setState(() {
      showFront = !showFront;
    });
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharactersViewModel>(context);
    final isFavourite = viewModel.favouriteCharacters.any((character) => character.id == widget.character.id);
    
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleCard,
          child: Card(
            elevation: 4,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: showFront ? _buildFront() : _buildBack(),
            ),
          ),
        ),

        // Звезда в правом верхнем углу
        Positioned(
          top: 12,
          right: 12,
          child: IconButton(
            onPressed: () async {
              if (isFavourite) {
                viewModel.removeFromFavouriteById(widget.character.id);
              } else {
                bool added = await viewModel.addToFavourite(widget.character);
                if(!added && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Можно добавить не более 8 персонажей в избранное.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } 
              }
            },
            icon: Icon(
              Icons.star,
              color: isFavourite ? Colors.yellow : Colors.grey,
              size: 28,
            ),
          ),

        ), 
      ],
    );
  }

  /// Лицевая сторона карточки: отображает изображение и имя персонажа
  Widget _buildFront() {
    return Container(
      key: const ValueKey('front'),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CachedImagePersistent(
              imageUrl: widget.character.image,
            ),
          ),
          const SizedBox(height: 8),
          BoldTitle(
            name: widget.character.name,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  /// Обратная сторона карточки
  Widget _buildBack() {
    return Container(
      key: const ValueKey('back'),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.character.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text('Status: ${widget.character.status}'),
          const SizedBox(height: 4),
          Text('Species: ${widget.character.species}'),
        ],
      ),
    );
  }
}