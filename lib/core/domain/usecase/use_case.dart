import 'package:abersoft_test_case/core/domain/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<ReturnValue, Params extends Equatable> {
  const UseCase();
  Future<Either<Failure, ReturnValue>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
