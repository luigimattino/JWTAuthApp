import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth.dart';
import 'repository/local_storage_repository.dart';
import 'services/auth-api/auth_api.dart';
import 'services/auth-api/token_service.dart';
import 'services/resource-api/resource_service.dart';

void main({String env}) {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(create: (context) => AuthHttpService()),
        RepositoryProvider<ResourceService>(
            create: (context) => ResourceService()),
        RepositoryProvider<AuthTokenService>(
            create: (context) => AuthTokenService(
                  localStorageRepository: LocalStorageRepository("tokens.json"),
                )),
      ],
      child: BlocProvider<AuthBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthService>(context);
            final authTokenService =
                RepositoryProvider.of<AuthTokenService>(context);
            return AuthBloc(authService, authTokenService)..add(AuthStarted());
          },
          child: App(environment: env)),
    ),
  );
}
