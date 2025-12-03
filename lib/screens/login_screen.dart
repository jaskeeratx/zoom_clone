import 'package:flutter/material.dart';
import 'package:untitled/components/custom_button.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/services/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Start or join the meeting',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 24),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: Image.asset('assets/images/onboarding.jpg'),
          ),
          CustomButton(buttonText: 'Login', onPressed:()async{
            bool? res = await _authMethods.signInWithGoogle(context);
            if(res==true){
              Navigator.pushNamed(context, '/home-screen');
            }
          },)

        ],
      ),
    );
  }
}
