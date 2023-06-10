import 'package:equatable/equatable.dart';
import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';

abstract class UseCase<type extends Object, Params> {
  Future<Result<type, AppException>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
