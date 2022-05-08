import 'package:flutter/material.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/ui/title_text.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Layout(
      child: Center(
        child: AppTitle(text: 'Coming soon...'),
      ),
    );
  }
}
