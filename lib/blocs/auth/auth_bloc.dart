import '../../services/auth-api/auth_service.dart';
import '../../services/auth-api/token_service.dart';
import '../../models/model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final AuthTokenService _authTokenService;
  AuthBloc(AuthService authService, AuthTokenService authTokenService)
      : assert(authService != null),
        assert(authTokenService != null),
        _authService = authService,
        _authTokenService = authTokenService,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedInToState(event);
    } else if (event is AuthRefresh) {
      yield* _mapAuthRefreshToState();
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutInToState();
    }
  }

  //AuthLoggedOut
  Stream<AuthState> _mapAuthLoggedOutInToState() async* {
    final authTokenData = await _authTokenService.getAuthData();
    await _authService
        .doLogout(RefreshToken(token: authTokenData.refreshToken));
    await _authTokenService.delete();
    yield AuthFailure();
  }

  //AuthLoggedIn
  Stream<AuthState> _mapAuthLoggedInToState(AuthLoggedIn event) async* {
    await _authTokenService.save(event.authResponse.data);
    yield AuthSuccess();
  }

  Stream<AuthState> _mapAuthRefreshToState() async* {
    try {
      final authTokenData = await _authTokenService.getAuthData();
      final response = await _authService
          .doRefresh(RefreshToken(token: authTokenData.refreshToken));
      if (response.success) {
        authTokenData.accessToken = response.data.accessToken;
        await FlutterSession().set('accessToken', response.data.accessToken);
        await _authTokenService.save(authTokenData);
        yield AuthRefreshed();
        yield AuthSuccess();
      } else {
        yield AuthFailure();
      }
    } catch (err) {
      yield AuthFailure();
    }
  }

  // AuthStarted
  Stream<AuthState> _mapAuthStartedToState() async* {
    final authTokenData = await _authTokenService.getAuthData();
    if (authTokenData != null) {
      await FlutterSession().set('accessToken', authTokenData.accessToken);
      yield AuthSuccess();
    } else {
      yield AuthFailure();
    }
  }
}
