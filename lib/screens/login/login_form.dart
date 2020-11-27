import 'package:JWTAuthApp/app_theme.dart';

import '../../app_routes.dart';
import '../../blocs/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.HomeRoute,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoading) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
        }
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
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: _submitButton(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: _registerButton(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _message() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginFailure) {
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
      if (state is LoginSuccess) {
        return Container(
          decoration: BoxDecoration(
              color: AppTheme.successTextBgColor,
              borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Icon(
                  Icons.check,
                  size: 36,
                  color: AppTheme.successTextColor,
                ),
                Text(
                  "User logged In successful!",
                  style: AppTheme.successTextStyle,
                ),
              ],
            ),
          ),
        );
      }
      return SizedBox.shrink();
    });
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

  Widget _submitButton() {
    return RaisedButton(
      child: Text('Login'),
      onPressed: _onLoginButtonPressed,
    );
  }

  Widget _registerButton() {
    return RaisedButton(
      child: Text(
        'Register now',
        style: AppTheme.secondaryTextStyle,
      ),
      color: AppTheme.secondaryColor,
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.RegisterRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  _onLoginButtonPressed() {
    if (_key.currentState.validate()) {
      _loginBloc.add(LoginInWithEmailButtonPressed(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
