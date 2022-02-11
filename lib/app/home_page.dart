import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_alert_dialog.dart';

import 'auth/Auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  const HomePage({Key key, this.auth}) : super(key: key);

  Future<Void> _signOut() async {
    try{
      await auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'log out',
        content: 'Are you sure that you want to logout',
        cancelActionText: 'Cancel',
        defaultActionText: 'Log out');
    if (didRequestSignOut == true) {
      _signOut(); //doesnt work fix hereqq
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          TextButton(
              onPressed: ()=> _confirmSignOut(context),
              child: Text('Logout',
              style: TextStyle(
                color: Colors.black
              ),))
        ],
      ),
    );
  }
}
