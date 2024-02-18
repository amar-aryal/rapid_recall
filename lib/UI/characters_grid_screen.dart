import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/UI/widgets/grid_card.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_bloc.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_event.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_state.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';

class CharacterGridScreen extends StatelessWidget {
  const CharacterGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharactersBloc(RepositoryProvider.of<DataRepository>(context))
            ..add(CharactersEvent.getCharactersEvent),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is CharactersLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is CharactersErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is CharactersLoadedState) {
              final hskCharacters = state.characters;

              return CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 2.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GridCard(character: hskCharacters[index]);
                      },
                      childCount: hskCharacters.length,
                    ),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
