import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:abersoft_test_case/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthInitial());

  void signIn({required String username, required String password}) async {
    emit(AuthLoading());

    final authOrFailure =
        await _authRepository.signIn(username: username, password: password);

    emit(
      authOrFailure.fold(
        (l) => AuthFailure(message: l.failureMessage()),
        (r) => AuthLoaded(token: r.token!),
      ),
    );
  }
}
