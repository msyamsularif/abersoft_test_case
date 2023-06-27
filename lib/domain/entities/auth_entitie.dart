import 'package:equatable/equatable.dart';

import 'package:abersoft_test_case/data/models/auth_data_model.dart';

class AuthEntitie extends Equatable {
  final AuthDataModel authDataModel;

  const AuthEntitie({
    required this.authDataModel,
  });

  @override
  List<Object?> get props => [authDataModel];
}
