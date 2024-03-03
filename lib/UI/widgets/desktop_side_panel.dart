import 'package:flutter/material.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_bloc.dart';
import 'package:rapid_recall/utils/context_extension.dart';

class DesktopSidePanel extends StatelessWidget {
  final CharactersBloc charactersBloc;
  final Function(int) onClick;
  const DesktopSidePanel({
    super.key,
    required this.charactersBloc,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: context.height,
        child: Column(
          children: [1, 2, 3, 4, 5, 6]
              .map(
                (no) => MaterialButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Text(
                    'HSK $no',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    onClick(no);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
