abstract class LogEvent {}

class CheckLoginStateEvent extends LogEvent {}

class LoginEvent extends LogEvent {
  String mtoken;
  LoginEvent({required this.mtoken});
}
