part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final String token;

  const AuthLoaded({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
