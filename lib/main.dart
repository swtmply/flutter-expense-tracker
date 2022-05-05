import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/models/user/user_model.dart';
import 'package:gas2s/screens/add_transaction_screen.dart';
import 'package:gas2s/screens/home_screen.dart';
import 'package:gas2s/screens/setup_screen.dart';
import 'package:gas2s/screens/transactions_screen.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<User>('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<User> user = Hive.box<User>('user');

    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.violet,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Navigation(),
        '/transactions': (context) => const TransactionsScreen(),
        '/add': (context) => const AddTrasactionScreen(),
      },
      home: user.isEmpty ? const SetupScreen() : const Navigation(),
    );
  }
}
