import 'package:abersoft_test_case/app.dart';
import 'package:abersoft_test_case/core/utils/theme.dart';
import 'package:abersoft_test_case/presentation/bloc/auth/auth_cubit.dart';
import 'package:abersoft_test_case/presentation/pages/login_page.dart';
import 'package:abersoft_test_case/presentation/pages/product_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Service Locator
  await di.init();

  // Configure bloc delegate
  Bloc.observer = AppBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => di.sl<AuthCubit>(),
      child: MaterialApp(
        initialRoute: LoginPage.routName,
        theme: themeData,
        routes: {
          LoginPage.routName: (context) => const LoginPage(),
          ProductPage.routName: (context) => const ProductPage(),
        },
      ),
    );
  }
}
