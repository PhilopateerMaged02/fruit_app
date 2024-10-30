import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/Authorization/authorization.dart';
import 'package:fruit_app/Cubits/CreateUserCubit/create_user_states.dart';

class CreateUserCubit extends Cubit<CreateUserStates> {
  CreateUserCubit(this.authorization) : super(CreateUserStateInitial());
  final Authorization authorization;
  Future<void> createUser(String email, String password) async {
    emit(CreateUserStateLoading());
    final result = await authorization.createUser(email, password);
    result.fold(
      (l) => emit(CreateUserStateError(message: l.error)),
      (r) => emit(CreateUserStateSuccess(userEntity: r)),
    );
  }
}
