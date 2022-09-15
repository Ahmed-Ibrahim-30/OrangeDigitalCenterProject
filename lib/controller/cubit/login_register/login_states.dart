abstract class LoginStates{}
class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class LogoutSuccessState extends LoginStates{}
class LogoutErrorState extends LoginStates{
  final String error;
  LogoutErrorState(this.error);
}

class RegisterLoadingState extends LoginStates{}
class RegisterSuccessState extends LoginStates{}
class RegisterErrorState extends LoginStates{
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends LoginStates{}
class CreateUserSuccessState extends LoginStates{}
class CreateUserErrorState extends LoginStates{
  final String error;
  CreateUserErrorState(this.error);
}


class ChangePasswordVisibilityState extends LoginStates{}
class ChangeFormState extends LoginStates{}
class ChangeGenderValueState extends LoginStates{}
class ChangeGradeValueState extends LoginStates{}
class ChangeUniversityValueState extends LoginStates{}
class GetUniversityNameState extends LoginStates{}
class GetGradeNameState extends LoginStates{}