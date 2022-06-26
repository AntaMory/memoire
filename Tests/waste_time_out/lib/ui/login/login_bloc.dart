import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<ValidateLoginFieldsEvent>((event, emit) {
      if (event.key.currentState?.validate() ?? false) {
        event.key.currentState!.save();
        emit(ValidLoginFields());
      } else {
        emit(LoginFailureState(errorMessage: 'Please fill required fields.'));
      }
    });
  }
}

abstract class LoginEvent {}

class ValidateLoginFieldsEvent extends LoginEvent {
  GlobalKey<FormState> key;

  ValidateLoginFieldsEvent(this.key);
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class ValidLoginFields extends LoginState {}

class LoginFailureState extends LoginState {
  String errorMessage;

  LoginFailureState({required this.errorMessage});
}