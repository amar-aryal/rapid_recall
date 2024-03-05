import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/UI/widgets/desktop_side_panel.dart';
import 'package:rapid_recall/UI/widgets/grid_card.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_bloc.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_event.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_state.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';

class CharacterGridScreen extends StatefulWidget {
  final VoidCallback onThemeChange;
  const CharacterGridScreen({super.key, required this.onThemeChange});

  @override
  State<CharacterGridScreen> createState() => _CharacterGridScreenState();
}

class _CharacterGridScreenState extends State<CharacterGridScreen>
    with TickerProviderStateMixin {
  final alphabetsList =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  late String selectedAlphabet;
  late ValueNotifier<int> hskNo;
  late TabController tabController;

  initializeDropdown() {
    selectedAlphabet = alphabetsList[0];
  }

  onHskChanged(int no, BuildContext ctx) {
    final charactersBloc = BlocProvider.of<CharactersBloc>(ctx);

    charactersBloc.add(GetCharactersEvent(hskNo: no));

    hskNo.value = no;

    initializeDropdown();
  }

  @override
  void initState() {
    super.initState();

    initializeDropdown();
    hskNo = ValueNotifier(1);
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    hskNo.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharactersBloc(RepositoryProvider.of<DataRepository>(context))
            ..add(GetCharactersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: IconButton(
            icon: const Icon(Icons.light),
            onPressed: widget.onThemeChange,
          ),
          // bottom: Platform.isAndroid || Platform.isIOS
          //     ? PreferredSize(
          //         preferredSize: const Size.fromHeight(40),
          //         child: Builder(builder: (ctx) {
          //           return TabBar(
          //             controller: tabController,
          //             isScrollable: true,
          //             tabs: [1, 2, 3, 4, 5, 6]
          //                 .map((no) => Text('HSK $no'))
          //                 .toList(),
          //             onTap: (value) {
          //               // +1 because value = index
          //               onHskChanged(value + 1, ctx);
          //             },
          //           );
          //         }),
          //       )
          //     : null,
        ),
        // In desktop, side nav, in mobile tab bar view
        body: Row(
          children: [
            if (!Platform.isIOS && !Platform.isAndroid)
              ValueListenableBuilder(
                valueListenable: hskNo,
                builder: (context, value, _) {
                  return DesktopSidePanel(
                    currentSelectedHsk: hskNo.value,
                    onClick: (no) {
                      //
                      onHskChanged(no, context);
                    },
                  );
                },
              ),
            Flexible(
              flex: 4,
              child: BlocBuilder<CharactersBloc, CharactersState>(
                builder: (context, state) {
                  final charactersBloc =
                      BlocProvider.of<CharactersBloc>(context);

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
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: StickyHeader(
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Row(
                                children: [
                                  DropdownButton(
                                    value: selectedAlphabet,
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
                                        //
                                        selectedAlphabet = value;

                                        charactersBloc.add(
                                          FilterCharactersEvent(
                                            (value.toLowerCase(), hskNo.value),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Text('RESET'),
                                    onPressed: () {
                                      //
                                      charactersBloc.add(GetCharactersEvent(
                                          hskNo: hskNo.value));

                                      initializeDropdown();
                                    },
                                  ),
                                ],
                              ),
                            ),
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
          ],
        ),
      ),
    );
  }
}

class StickyHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  const StickyHeader({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
