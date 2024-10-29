import 'package:dartz/dartz.dart';
import 'package:fruit_app/Authorization/authorization.dart';
import 'package:fruit_app/Failures/errors.dart';
import 'package:fruit_app/Failures/exceptions.dart';
import 'package:fruit_app/Service/FirebaseAuthService.dart';
import 'package:fruit_app/models/UserEntity/user_entity.dart';
import 'package:fruit_app/models/UserModel/user_model.dart';

class AuthorizationImpl extends Authorization {
  final Firebaseauthservice firebaseauthservice;
  AuthorizationImpl({required this.firebaseauthservice});
  @override
  Future<Either<Errors, UserEntity>> createUser(
      String email, String password) async {
    try {
      var user = await firebaseauthservice.createUser(
          email: email, Password: password);
      return right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
