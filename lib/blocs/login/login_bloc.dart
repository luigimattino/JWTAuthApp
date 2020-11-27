import '../../models/model.dart';

import '../../exception/auth_exception.dart';
import '../auth/auth.dart';
import '../../services/auth-api/auth_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final AuthService _authService;

  LoginBloc(AuthBloc authenticationBloc, AuthService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authBloc = authenticationBloc,
        _authService = authenticationService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailAndPasswordToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailAndPasswordToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final response = await _authService
          .doLogin(User(username: event.email, password: event.password));
      if (response.success) {
        _authBloc.add(AuthLoggedIn(authResponse: response));
        yield LoginSuccess();
        yield await Future.delayed(const Duration(seconds: 6), () async {
          return LoginInitial();
        });
      } else {
        yield LoginFailure(error: response.message);
      }
    } on AuthException catch (err) {
      yield LoginFailure(error: err.message);
    } catch (err) {
      yield LoginFailure(
          error: err.message || err.message.isEmpty ??
              'An unexpected error occured');
    }
  }
}
