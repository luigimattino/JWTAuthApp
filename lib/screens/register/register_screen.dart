import '../../services/auth-api/auth_service.dart';
import '../../blocs/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) {
          final authService = RepositoryProvider.of<AuthService>(context);
          return RegisterBloc(authService);
        },
        child: RegisterForm(),
      ),
    );
  }
}
