import 'package:flutter/material.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/ui/title_text.dart';

class SettingsMenuScreen extends StatefulWidget {
  const SettingsMenuScreen({Key? key}) : super(key: key);

  @override
  State<SettingsMenuScreen> createState() => _SettingMenusScreenState();
}

class _SettingMenusScreenState extends State<SettingsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return const Layout(
      child: Center(
        child: AppTitle(text: 'Coming soon...'),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const SizedBox(
      //       height: 60,
      //     ),
      //     const AppTitle(text: 'Menu'),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     ListTile(
      //       contentPadding: EdgeInsets.zero,
      //       leading: const Icon(Icons.payment),
      //       title: const Text('Transactions'),
      //       iconColor: AppColors.coolGray,
      //       onTap: () {},
      //     ),
      //     ListTile(
      //       contentPadding: EdgeInsets.zero,
      //       leading: const Icon(Icons.account_balance_wallet_outlined),
      //       title: const Text('Balance'),
      //       iconColor: AppColors.coolGray,
      //       onTap: () {},
      //     ),
      //     ListTile(
      //       contentPadding: EdgeInsets.zero,
      //       leading: const Icon(Icons.color_lens_outlined),
      //       title: const Text('Colors'),
      //       iconColor: AppColors.coolGray,
      //       onTap: () {},
      //     ),
      //     const Divider(
      //       thickness: 1,
      //       color: AppColors.coolGray,
      //     ),
      //     ListTile(
      //       contentPadding: EdgeInsets.zero,
      //       leading: const Icon(Icons.notifications_outlined),
      //       title: const Text('Notifications'),
      //       iconColor: AppColors.coolGray,
      //       onTap: () {},
      //     ),
      //     ListTile(
      //       contentPadding: EdgeInsets.zero,
      //       leading: const Icon(Icons.person_outline),
      //       title: const Text('Settings'),
      //       iconColor: AppColors.coolGray,
      //       onTap: () {
      //         Navigator.pushNamed(context, '/settings/user');
      //       },
      //     )
      //   ],
      // ),
    );
  }
}
