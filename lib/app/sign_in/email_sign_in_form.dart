import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/auth/Auth.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;

  EmailSignInForm({this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState(auth);
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final AuthBase auth;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  _EmailSignInFormState(this.auth);

  String get _email => _emailEditingController.text;
  String get _password => _passwordEditingController.text;
  bool _submited = false;
  bool _isLoading = false;

  void _submit() async {
    log('submit pressed');
    _submited = true;
    _isLoading = true;
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      log(e.toString());
      showAlertDialog(context, title: 'Sign in failed', content: e.toString(), defaultActionText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toogleFormType() {
    setState(() {
      _submited = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailEditingController.clear();
    _passwordEditingController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'create an account';
    final seconderyText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      ElevatedButton(
          child: Text(primaryText), onPressed: submitEnabled ? _submit : null),
      TextButton(
          onPressed: () {
            _toogleFormType();
          },
          child: Text(seconderyText))
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submited && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordEditingController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      onChanged: (password) {
        setState(() {});
      },
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submited && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailEditingController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      onChanged: (email) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
