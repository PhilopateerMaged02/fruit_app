import 'package:dartz/dartz.dart';
import 'package:fruit_app/Authorization/authorization.dart';
import 'package:fruit_app/Failures/errors.dart';
import 'package:fruit_app/Service/FirebaseAuthService.dart';
import 'package:fruit_app/models/UserEntity/user_entity.dart';
import 'package:fruit_app/models/UserEntity/user_model.dart';
import 'package:fruit_app/models/UserModel/user_model.dart';

class AuthorizationImpl extends Authorization {
  final Firebaseauthservice firebaseauthservice;
  AuthorizationImpl({required this.firebaseauthservice});
  @override
  Future<Either<Errors, UserEntity>> createUser(
      String email, String password, String name) async {
    var user =
        await firebaseauthservice.createUser(email: email, Password: password);
    return right(
      UserModel.fromFirebaseUser(user),
    );
  }
}
