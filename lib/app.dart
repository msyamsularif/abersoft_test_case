import 'package:abersoft_test_case/app/service/bloc_observer.dart';
import 'package:abersoft_test_case/app/service/dio_config_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'injection_container.dart' as di;

class App {
  static Future<void> init() async {
    // Service Locator
    await di.init();

    // Configure bloc delegate
    Bloc.observer = AppBlocObserver();

    // Dio Interceptors
    di.sl<Dio>().interceptors.add(DioLoggingInterceptors());
  }
}
