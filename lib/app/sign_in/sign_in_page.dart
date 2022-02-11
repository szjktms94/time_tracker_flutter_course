import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/auth/Auth.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/sign_in_button.dart';

import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;

  const SignInPage({Key key, this.auth}) : super(key: key);

  Future<Void> _signInAnonimously() async {
    try{
      await auth.signInAnonymously();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Void> _signInWithGoogle() async {
    try{
      await auth.signInWithGoogle();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Void> _signInWithFacebook() async {
    try{
      await auth.signInWithFacebook();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(auth: auth,),
        )
    );
  }
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.black38),
          ),
          SizedBox(height: 6),
          CustomElevatedButton(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Image.asset('images/google-logo.png'),
              Text('Sign In with Google'),
              Opacity(opacity: 0.0,
              child: Image.asset('images/google-logo.png')),
            ]),
            onPressed: _signInWithGoogle
          ),
          SizedBox(height: 6),
          CustomElevatedButton(
            color: Color(0xFF334D92),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Image.asset('images/facebook-logo.png'),
              Text('Sign In with Facebook',style: TextStyle(color: Colors.white),),
              Opacity(opacity: 0.0,
                  child: Image.asset('images/facebook-logo.png')),
            ]),
            onPressed: _signInWithFacebook,
          ),
          SizedBox(height: 6),
          SignInButton(
            text: 'Sign In with email',
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(height: 6),
          Text(
            "Or",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black38),
          ),
          SizedBox(height: 6),
          SignInButton(
            text: 'Sign In anonymously',
            onPressed: () {
              log('Anonymus');
              _signInAnonimously();
            },
          ),
        ],
      ),
    );
  }
}
