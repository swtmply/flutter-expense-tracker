import 'package:flutter/material.dart';
import 'package:gas2s/theme/colors.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.coolWhite,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
