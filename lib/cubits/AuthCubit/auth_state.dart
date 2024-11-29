part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginLoading extends AuthState {}
final class LoginSuccessfully extends AuthState {}
final class LoginFailure extends AuthState {

  final String message;

  LoginFailure(this.message);
}
final class RegisterLoading extends AuthState {}
final class RegisterSuccess extends AuthState {}
final class RegisterFailure extends AuthState {
  final String Message;

  RegisterFailure(this.Message);
}

