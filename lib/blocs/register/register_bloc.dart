import '../../exception/auth_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/model.dart';
import '../../services/auth-api/auth_api.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService;

  RegisterBloc(AuthService authenticationService)
      : assert(authenticationService != null),
        _authService = authenticationService,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterWithEmailAndPasswordButtonPressed) {
      yield* _mapRegisterWithEmailAndPasswordToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterWithEmailAndPasswordToState(
      RegisterWithEmailAndPasswordButtonPressed event) async* {
    yield RegisterLoading();
    try {
      final response = await _authService
          .doSignup(User(username: event.email, password: event.password));
      if (response.success) {
        yield RegisterSuccess();
      } else {
        yield RegisterFailure(error: response.message);
      }
    } on AuthException catch (err) {
      yield RegisterFailure(error: err.message);
    } catch (err) {
      yield RegisterFailure(
          error: err.message || err.message.isEmpty ??
              'An unexpected error occured');
    }
  }
}
