import 'package:flutter/material.dart';
import 'package:rapid_recall/utils/context_extension.dart';

class DesktopSidePanel extends StatelessWidget {
  final Function(int) onClick;
  final int currentSelectedHsk;

  const DesktopSidePanel({
    super.key,
    required this.onClick,
    required this.currentSelectedHsk,
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
                  color: currentSelectedHsk == no ? Colors.blueGrey : null,
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
