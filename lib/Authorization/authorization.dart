import 'package:dartz/dartz.dart';
import 'package:fruit_app/Failures/errors.dart';
import 'package:fruit_app/models/UserEntity/user_entity.dart';

abstract class Authorization {
  Future<Either<Errors, UserEntity>> createUser(String name, String password);
}
