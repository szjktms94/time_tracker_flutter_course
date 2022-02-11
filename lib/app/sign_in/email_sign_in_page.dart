import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/auth/Auth.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  const EmailSignInPage({Key key, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(child: EmailSignInForm(auth: auth,))),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

}
