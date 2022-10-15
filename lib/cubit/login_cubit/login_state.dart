part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoding extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailuer extends LoginState {
  String messageError;
  LoginFailuer({required this.messageError});

}
