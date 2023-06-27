import 'package:equatable/equatable.dart';

class AuthEntitie extends Equatable {
  final String username;
  final String password;

  const AuthEntitie({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
