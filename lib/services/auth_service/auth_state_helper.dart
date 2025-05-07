import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/pages/authentication/email_verification.dart';

import '../../pages/home_page.dart';
import 'login_or_register.dart';

class AuthStateHelper extends StatefulWidget {
  const AuthStateHelper({super.key});

  @override
  State<AuthStateHelper> createState() => _AuthStateHelperState();
}

class _AuthStateHelperState extends State<AuthStateHelper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data!.emailVerified){
            return const HomePage();
          }else{
            return const EmailVerification();
          }
        }else{
          return const LoginOrRegister();
        }
      },
    );
  }
}
