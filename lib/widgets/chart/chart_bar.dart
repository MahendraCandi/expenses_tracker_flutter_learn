import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double barHeight;

  const ChartBar({super.key, required this.barHeight});

  @override
  Widget build(BuildContext context) {
    var isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: barHeight, // percentage height of the bar. between 0 - 1
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
