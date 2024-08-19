import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
// general failure

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
