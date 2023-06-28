import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/presentation/bloc/auth/auth_cubit.dart';
import 'package:abersoft_test_case/presentation/pages/product_page.dart';
import 'package:abersoft_test_case/presentation/widgets/ct_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit _authCubit;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

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
              obscureText: true,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                _authCubit.signIn(
                  username: _usernameController.text,
                  password: _passwordController.text,
                );
              },
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade400,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is AuthLoaded) {
                    Navigator.pushNamed(context, ProductPage.routName);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return const Text('LOGIN');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
