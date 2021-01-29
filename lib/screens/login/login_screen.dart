import '../../blocs/login/login.dart';

import '../../blocs/auth/auth.dart';
import '../../services/auth-api/auth_api.dart';
import 'login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: BlocProvider<LoginBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthService>(context);
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return LoginBloc(authBloc, authService);
          },
          child: SingleChildScrollView(
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
