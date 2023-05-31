import 'package:flutter_bloc/flutter_bloc.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitEvent) {
      yield LoginLoading();

      try {
        // Perform the login logic here
        // You can use Firebase Auth or any other authentication mechanism
        // Replace the code below with your login logic
        await Future.delayed(Duration(seconds: 2));

        // Simulating a successful login
        yield LoginSuccess();
      } catch (e) {
        // Handle login errors
        yield LoginError(e.toString());
      }
    }
  }
}
