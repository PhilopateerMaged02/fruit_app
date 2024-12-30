import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/Login/login_screen.dart';
import 'package:fruit_app/modules/Register/cubit/states.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FruitAppRegisterCubit extends Cubit<FruitAppRegisterStates> {
  FruitAppRegisterCubit() : super(FruitAppRegisterInitialState());
  static FruitAppRegisterCubit get(context) => BlocProvider.of(context);
  bool CheckBoxvisibility = false;
  void changeCheckBoxVisibility() {
    CheckBoxvisibility = !CheckBoxvisibility;
    emit(SocialRegisterChangeCheckBoxState());
  }

  void createUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required context,
  }) async {
    emit(FruitAppRegisterLoadingState());
    try {
      if (CheckBoxvisibility == true) {
        // Sign up the user
        final AuthResponse res = await supabase.auth.signUp(
          email: email,
          password: password,
          data: {
            'Display name': name,
            'Phone': phone,
            'profile_image':
                "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
          },
        );

        // Check if user is created
        if (res.user != null) {
          // Insert user data into the 'users' table
          await supabase.from('users').insert({
            'uId': res.user!.id,
            'name': name,
            'email': email,
            'phone': phone,
            'profile_image':
                "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
          });
          emit(FruitAppRegisterSuccessState());
          showToust(
              message: "Signed up Successfully", state: ToastStates.SUCCESS);
          navigateTo(context, LoginScreen());
        } else {
          debugPrint('Sign-up failed: user is null');
          emit(FruitAppRegisterErrorState(
              "Failed to register user: user is null"));
        }
      } else {
        showToust(message: "يجب الموافقة على الشروط", state: ToastStates.ERROR);
      }
    } catch (error) {
      debugPrint('Error during registration: $error');
      emit(FruitAppRegisterErrorState(error.toString()));
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  bool visibility = true;
  IconData suffix = Icons.visibility_outlined;
  void changeVisibility() {
    visibility = !visibility;
    suffix =
        visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
