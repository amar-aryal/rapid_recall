import 'package:flutter/material.dart';
import 'package:rapid_recall/data/models/character.dart';

class GridCard extends StatelessWidget {
  final Character character;
  const GridCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // USE THEMES
    return SizedBox.square(
      // dimension: MediaQuery.of(context).size.width * 0.05,
      child: Card(
        child: Text(
          character.hanzi,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
