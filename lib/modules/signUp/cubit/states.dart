abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{}
class SignUperrorState extends SignUpStates {
  final String error;
  SignUperrorState({required this.error});
}

class CreateUserLoadingState extends SignUpStates{}
class CreateUserSuccessState extends SignUpStates{}
class CreateUsererrorState extends SignUpStates {
  final String error;
  CreateUsererrorState({required this.error});
}
class SignUpChangePasswordVisibility extends SignUpStates{}

