import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/presentation/widgets/ct_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 84,
          horizontal: 66,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 235,
              height: 53,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ConstantAssets.abersoftLogo),
                ),
              ),
            ),
            const SizedBox(height: 120),
            CTTextField(
              controller: _usernameController,
              labelText: 'Username',
            ),
            const SizedBox(height: 16),
            CTTextField(
              controller: _passwordController,
              labelText: 'Password',
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {},
              child: const Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}
