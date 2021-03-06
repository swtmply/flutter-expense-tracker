import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/models/user/user_model.dart';
import 'package:gas2s/screens/sections/add_transaction.dart';
import 'package:gas2s/screens/main/setup.dart';
import 'package:gas2s/screens/sections/transactions.dart';
import 'package:gas2s/screens/settings/user_settings.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/navigations/bottom_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<User>('user');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Box<User> user = Hive.box<User>('user');

    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.violet,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const BottomNavigation(),
        '/transactions': (context) => const TransactionsScreen(),
        '/add': (context) => const AddTrasactionScreen(),
        '/settings/user': (context) => const UserSettings(),
      },
      home: user.isEmpty ? const SetupScreen() : const BottomNavigation(),
    );
  }
}
