import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import 'blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'app_config.dart';
import 'blocs/auth/auth_state.dart';
import 'screens/login/login_screen.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  final environment;
  App({this.environment});

  @override
  Widget build(BuildContext context) {
    AppConfig().forEnvironment(environment);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication App with JWT',
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure) {
            return LoginScreen();
          }
          if (state is AuthSuccess) {
            return HomeScreen();
          }
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(child: Text("Loading")),
            ),
          );
        },
      ),
      onGenerateRoute: AppRoutes.routes,
      theme: AppTheme.theme,
    );
  }
}
