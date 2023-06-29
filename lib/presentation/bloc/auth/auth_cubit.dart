import 'package:abersoft_test_case/core/utils/constants.dart';
import 'package:abersoft_test_case/domain/usecase/auth_use_case.dart';
import 'package:abersoft_test_case/injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase _authUseCase;

  AuthCubit({
    required AuthUseCase authUseCase,
  })  : _authUseCase = authUseCase,
        super(AuthInitial());

  void signIn({required String username, required String password}) async {
    emit(AuthLoading());

    final authOrFailure = await _authUseCase(
      AuthParams(username: username, password: password),
    );

    emit(
      authOrFailure.fold(
        (l) => AuthFailure(message: l.failureMessage()),
        (r) {
          // Create secure storage for save token
          final secureStorage = di.sl<FlutterSecureStorage>();

          secureStorage.write(key: ConstantName.keyToken, value: r.token);

          return AuthLoaded(token: r.token!);
        },
      ),
    );
  }
}
