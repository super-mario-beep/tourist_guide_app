import 'package:flutter/material.dart';

/// Fills the rest of a scroll view and centers [child] in it.
/// Used for loading, empty and error states below a page title.
class CenteredSliver extends StatelessWidget {
  const CenteredSliver({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        // Lifts the content slightly above the true center, like the design.
        padding: const EdgeInsets.only(bottom: 60),
        child: Center(child: child),
      ),
    );
  }
}
