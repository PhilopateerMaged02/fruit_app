import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_app/Service/shared_pref.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/cubit/states.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FruitAppLoginCubit extends Cubit<FruitAppLoginStates> {
  FruitAppLoginCubit() : super(FruitAppLoginInitialState());
  static FruitAppLoginCubit get(context) => BlocProvider.of(context);

  void signIn({
    required context,
    required String email,
    required String password,
  }) async {
    emit(FruitAppLoginLoadingState());
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res != null && res.user != null) {
        emit(FruitAppLoginSuccessState());
        showToust(
            message: "Signed in Successfully", state: ToastStates.SUCCESS);
        uId = res.user!.id;
        SharedPrefrencesSingleton.setString('uId', uId!);
        print(uId);
        print(res.user!.email);
        navigateTo(context, FruitappLayout()); // Safely access the user ID.
      } else {
        showToust(message: "Something Wrong", state: ToastStates.ERROR);
        emit(FruitAppLoginErrorState());
      }
    } catch (error) {
      showToust(
          message: "Email or password is wrong", state: ToastStates.ERROR);
      emit(FruitAppLoginErrorState());
      print('Sign-in error: $error'); // Log the error for debugging.
    }
  }

  Future<void> signInWithGoogle(context) async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://ywjzourlwwrtnksnlbri.supabase.co/auth/v1/callback',
      );
      final session = supabase.auth.currentSession;
      final user = supabase.auth.currentUser;

      if (user != null) {
        print('User signed in: ${user.email}');
        print('User signed in: ${user.id}');
        print('User signed in: ${uId}');
        navigateTo(context, FruitappLayout());
      } else {
        print('Google sign-in failed or no user data found.');
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
    }
  }

  void signInWithFacebook(context) async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'https://ywjzourlwwrtnksnlbri.supabase.co/auth/v1/callback',
      );
      final session = supabase.auth.currentSession;
      final user = supabase.auth.currentUser;
      if (user != null) {
        print('User signed in: ${user.email}');
        print('User signed in: ${user.id}');
        print('User signed in: ${uId}');
        navigateTo(context, FruitappLayout());
      } else {
        print('facebook sign-in failed or no user data found.');
      }
    } catch (error) {
      print('Error during facebook Sign-In: $error');
    }
  }

  bool visibility = true;
  IconData suffix = Icons.visibility_outlined;
  void changeVisibility() {
    visibility = !visibility;
    suffix =
        visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}
