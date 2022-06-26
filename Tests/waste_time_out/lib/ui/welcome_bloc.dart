import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

//part 'welcome_event.dart';

//part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeInitial> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<LoginPressed>((event, emit) {
      emit(WelcomeInitial(pressTarget: WelcomePressTarget.login));
    });
    on<SignupPressed>((event, emit) {
      emit(WelcomeInitial(pressTarget: WelcomePressTarget.signup));
    });
  }
}

//part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeEvent {}

class LoginPressed extends WelcomeEvent {}

class SignupPressed extends WelcomeEvent {}



//part of 'welcome_bloc.dart';

enum WelcomePressTarget { login, signup }


class WelcomeInitial {
  WelcomePressTarget? pressTarget;

  WelcomeInitial({this.pressTarget});
}