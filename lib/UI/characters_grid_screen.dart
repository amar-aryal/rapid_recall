import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/UI/widgets/grid_card.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_bloc.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_event.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_state.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';

class CharacterGridScreen extends StatefulWidget {
  const CharacterGridScreen({super.key});

  @override
  State<CharacterGridScreen> createState() => _CharacterGridScreenState();
}

class _CharacterGridScreenState extends State<CharacterGridScreen> {
  final alphabetsList =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  late String selectedAlphabet;

  @override
  void initState() {
    super.initState();

    selectedAlphabet = alphabetsList[0];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharactersBloc(RepositoryProvider.of<DataRepository>(context))
            ..add(GetCharactersEvent(hskNo: 3)),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            final charactersBloc = BlocProvider.of<CharactersBloc>(context);

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
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        DropdownButton(
                          value:
                              selectedAlphabet, // TRY:SELECT LOGIC IN BLOC CLASS
                          items: alphabetsList
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              selectedAlphabet = value;
                              charactersBloc.add(
                                FilterCharactersEvent(
                                  (value.toLowerCase(), 3),
                                ),
                              );
                            }
                          },
                        ),
                        MaterialButton(
                          child: const Text('TEST FILTER'),
                          onPressed: () {
                            charactersBloc.add(
                              FilterCharactersEvent(
                                ('a', 1),
                              ),
                            );
                          },
                        ),
                        MaterialButton(
                          child: const Text('RESET'),
                          onPressed: () {
                            charactersBloc.add(GetCharactersEvent());
                          },
                        ),
                      ],
                    ),
                  ),
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
