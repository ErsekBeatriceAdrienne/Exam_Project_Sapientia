import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: FloatingActionButton.extended(
            onPressed: (){},
            /*icon: Image.asset('assets/images/google_logo.png',
            height: 32,
            width: 32,),*/
            label : Text('Sign in with Google'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
      ),
    ));
  }
}