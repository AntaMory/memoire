import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:waste_time_out/constant.dart';
import 'package:waste_time_out/model/user.dart';
import 'package:waste_time_out/service/authentification.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authenticate_state.dart';

part 'authenticate_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;
  late SharedPreferences prefs;
  late bool finishedOnBoarding;

  AuthenticationBloc({this.user})
      : super(const AuthenticationState.unauthenticated()) {
    on<CheckFirstRunEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();
      finishedOnBoarding = prefs.getBool(FINISHED_ON_BOARDING) ?? false;
      if (!finishedOnBoarding) {
        emit(const AuthenticationState.onboarding());
      } else {
        user = await FireStoreUtils.getAuthUser();
        if (user == null) {
          emit(const AuthenticationState.unauthenticated());
        } else {
          emit(AuthenticationState.authenticated(user!));
        }
      }
    });
    on<FinishedOnBoardingEvent>((event, emit) async {
      await prefs.setBool(FINISHED_ON_BOARDING, true);
      emit(const AuthenticationState.unauthenticated());
    });
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
          event.email, event.password);
      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Login failed, Please try again.'));
      }
    });


    on<LoginWithPhoneNumberEvent>((event, emit) async {
      dynamic result =
      await FireStoreUtils.loginOrCreateUserWithPhoneNumberCredential(
          credential: event.credential,
          phoneNumber: event.phoneNumber,
          firstName: event.firstName,
          lastName: event.lastName,
          image: event.image);
      if (result is User) {
        user = result;
        emit(AuthenticationState.authenticated(result));
      } else if (result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      }
    });
    on<SignupWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await FireStoreUtils.signUpWithEmailAndPassword(
          emailAddress: event.emailAddress,
          password: event.password,
          image: event.image,
          firstName: event.firstName,
          lastName: event.lastName);
      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Couldn\'t sign up'));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await FireStoreUtils.logout();
      user = null;
      emit(const AuthenticationState.unauthenticated());
    });
  }
}