import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gas2s/models/user/user_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/ui/forms/number_field.dart';
import 'package:gas2s/widgets/ui/forms/text_field.dart';
import 'package:gas2s/widgets/ui/title_text.dart';
import 'package:hive/hive.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  Box<User> users = Hive.box<User>('user');

  String _name = '';
  int _balance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.coolWhite,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 80.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppTitle(text: 'User Setup'),
                const SizedBox(
                  height: 80,
                ),
                NumberField(
                  onChanged: (String value) {
                    setState(() {
                      _balance = int.tryParse(value) ?? 0;
                    });
                  },
                  label: 'Initial Balance for the Month',
                ),
                AppTextField(
                  onChanged: (String value) {
                    setState(() {
                      _name = value;
                    });
                  },
                  label: 'Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.violet,
                        AppColors.pink,
                      ],
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      padding: const EdgeInsets.only(),
                    ),
                    onPressed: () {
                      final user = User()
                        ..name = _name
                        ..balance = _balance.toDouble();

                      if (_balance != 0) {
                        users.add(user);
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
