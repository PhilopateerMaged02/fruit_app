abstract class FruitAppRegisterStates {}

class FruitAppRegisterInitialState extends FruitAppRegisterStates {}

class FruitAppRegisterLoadingState extends FruitAppRegisterStates {}

class FruitAppRegisterSuccessState extends FruitAppRegisterStates {}

class FruitAppRegisterErrorState extends FruitAppRegisterStates {
  final String error;
  FruitAppRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState
    extends FruitAppRegisterStates {}

class SocialRegisterChangeCheckBoxState extends FruitAppRegisterStates {}

class SocialRegisterTableErrorState extends FruitAppRegisterStates {}

class SocialRegisterTableSuccessState extends FruitAppRegisterStates {}
