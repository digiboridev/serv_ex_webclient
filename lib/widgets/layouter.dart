import 'package:flutter/material.dart';

class Layouter extends StatelessWidget {
  const Layouter({
    Key? key,
    required this.mobileLayout,
    required this.tabletLayout,
  }) : super(key: key);

  final Widget mobileLayout;
  final Widget tabletLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileLayout;
        } else {
          return tabletLayout;
        }
      },
    );
  }
}
