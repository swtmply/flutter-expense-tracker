import 'package:flutter/material.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/ui/title_text.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return const Layout(
      child: Center(
        child: AppTitle(
          text: 'Coming Soon...',
        ),
      ),
    );
  }
}
