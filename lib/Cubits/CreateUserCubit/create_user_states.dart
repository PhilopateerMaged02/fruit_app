import 'package:fruit_app/models/UserEntity/user_entity.dart';

class CreateUserStates {}

class CreateUserStateInitial extends CreateUserStates {}

class CreateUserStateLoading extends CreateUserStates {}

class CreateUserStateSuccess extends CreateUserStates {
  final UserEntity userEntity;

  CreateUserStateSuccess({required this.userEntity});
}

class CreateUserStateError extends CreateUserStates {
  final String message;

  CreateUserStateError({required this.message});
}
