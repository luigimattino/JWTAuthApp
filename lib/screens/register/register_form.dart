import '../../blocs/register/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../app_theme.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  RegisterBloc _registerBloc;

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.LoginRoute,
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(45.0),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _message(),
                  _emailField(),
                  _passwordField(),
                  _passwordConfirmField(),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: _submitButton(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: _loginButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _message() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is RegisterFailure) {
          return Container(
            decoration: BoxDecoration(
                color: AppTheme.errorTextBgColor,
                borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Icon(
                    Icons.warning,
                    size: 36,
                    color: AppTheme.errorTextColor,
                  ),
                  Text(
                    state.error,
                    style: AppTheme.errorTextStyle,
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: "Email",
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      validator: (String value) {
        if (value.isEmpty) {
          return 'E-mail is required';
        }
        if (!RegExp(
                r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)')
            .hasMatch(value)) {
          return 'Please enter a valid E-mail address';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: "Password",
      ),
      obscureText: true,
      autocorrect: false,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }

  Widget _passwordConfirmField() {
    return TextFormField(
      controller: _passwordConfirmController,
      decoration: InputDecoration(
        icon: Icon(Icons.check),
        labelText: "Confirm Password",
      ),
      obscureText: true,
      autocorrect: false,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Confirm Password is required';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match.';
        }
        return null;
      },
    );
  }

  Widget _submitButton() {
    return RaisedButton(
      child: Text('Register'),
      onPressed: _onRegisterButtonPressed,
    );
  }

  Widget _loginButton() {
    return RaisedButton(
      child: Text(
        'back to Login',
        style: AppTheme.secondaryTextStyle,
      ),
      color: AppTheme.secondaryColor,
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.LoginRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _registerBloc.close();
    super.dispose();
  }

  _onRegisterButtonPressed() {
    if (_key.currentState.validate()) {
      _registerBloc.add(RegisterWithEmailAndPasswordButtonPressed(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
