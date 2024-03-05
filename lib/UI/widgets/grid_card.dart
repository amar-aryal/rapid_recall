import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:rapid_recall/data/models/character.dart';
import 'package:rapid_recall/utils/context_extension.dart';

class GridCard extends StatelessWidget {
  final Character character;
  const GridCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // USE THEMES
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      character.hanzi,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      character.pinyin,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 15),
                    ...character.translations.map(
                      (e) => Text(
                        e,
                        style: Theme.of(context).textTheme.bodyLarge,
                        // textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          direction: PopoverDirection.top,
          height: context.height * 0.35,
          width: context.width * 0.6,
          arrowHeight: 15,
          arrowWidth: 30,
          radius: 15,
          backgroundColor: Theme.of(context).cardColor,
        );
      },
      child: SizedBox.square(
        child: Card(
          child: Center(
            child: Text(
              character.hanzi,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
    );
  }
}
