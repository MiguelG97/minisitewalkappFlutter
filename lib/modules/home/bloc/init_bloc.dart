import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/core/wrappers/injector.dart';
import 'package:minisitewalkapp/modules/home/bloc/init_events.dart';
import 'package:minisitewalkapp/modules/home/bloc/init_states.dart';

class InitBloc extends Bloc<LogEvent, LogginState> {
  InitBloc() : super(LoggedInState()) {
    on<CheckLoginStateEvent>(onCheckLoginStateEvent);
    on<LoginEvent>(onLoginEvent);
    // add(CheckLoginStateEvent());
  }

  void onCheckLoginStateEvent(
      CheckLoginStateEvent event, Emitter<LogginState> emit) async {
    emit(LoadingState());

    //get access token
    var accessToken = "";
    if (accessToken == null || accessToken == "") {
      emit(NotLoggedInState());
    } else {
      emit(LoggedInState());
    }
  }

  void onLoginEvent(LoginEvent event, Emitter<LogginState> emit) async {
    //storing tokens (bullshit!)
    // await DI()
    //     .getIt
    //     .get<FlutterSecureStorage>()
    //     .write(key: "access_token", value: event.mtoken);
    //load data!!
    emit(LoggedInState());
  }
}
