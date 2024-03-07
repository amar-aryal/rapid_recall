import 'package:flutter/material.dart';

class TabNavView extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final Function(int, BuildContext) onChanged;
  const TabNavView({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      tabs: [1, 2, 3, 4, 5, 6].map((no) => Text('HSK $no')).toList(),
      onTap: (value) {
        onChanged(value, context);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
