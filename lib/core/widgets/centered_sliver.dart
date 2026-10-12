import 'package:flutter/material.dart';

class CenteredSliver extends StatelessWidget {
  const CenteredSliver({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Center(child: child),
      ),
    );
  }
}
