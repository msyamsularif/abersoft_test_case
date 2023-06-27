import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String failureMessage();

  @override
  List<Object> get props => [];
}

/// General failures
class ServerFailure extends Failure {
  final String? message;

  ServerFailure({
    this.message,
  });

  @override
  String failureMessage() {
    return message ?? 'Server Failure';
  }
}
