import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction_model.dart';
import 'package:gas2s/screens/home_screen.dart';
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
  await Hive.openBox<Transaction>('transactions');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.violet,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/transactions': (context) => TransactionsScreen(),
      },
      home: Navigation(),
    );
  }
}
