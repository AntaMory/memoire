import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:waste_time_out/service/authentification.dart';

//part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  resetPassword(String email) async {
    await FireStoreUtils.resetPassword(email);
    emit(ResetPasswordDone());
  }

  checkValidField(GlobalKey<FormState> key) {
    if (key.currentState?.validate() ?? false) {
      key.currentState!.save();
      emit(ValidResetPasswordField());
    } else {
      emit(ResetPasswordFailureState(errorMessage: 'Invalid email address.'));
    }
  }
}

//part of 'reset_password_cubit.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ValidResetPasswordField extends ResetPasswordState {}

class ResetPasswordFailureState extends ResetPasswordState {
  String errorMessage;

  ResetPasswordFailureState({required this.errorMessage});
}

class ResetPasswordDone extends ResetPasswordState {}