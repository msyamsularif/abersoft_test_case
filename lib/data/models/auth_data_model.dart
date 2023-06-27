import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthDataModel extends Equatable {
  final String? token;
  final String? message;

  const AuthDataModel({
    this.token,
    this.message,
  });

  @override
  List<Object?> get props => [token, message];

  AuthDataModel copyWith({
    String? token,
    String? message,
  }) {
    return AuthDataModel(
      token: token ?? this.token,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'message': message,
    };
  }

  factory AuthDataModel.fromJson(Map<String, dynamic> map) {
    return AuthDataModel(
      token: map['token'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
