import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/components/auth_button.dart';
import 'package:tasker/services/auth_service/auth_state_helper.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth
      .instance
      .currentUser
      !.sendEmailVerification();

    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        FirebaseAuth.instance.currentUser!.reload();
        if(FirebaseAuth.instance.currentUser!.emailVerified){
          timer.cancel();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthStateHelper(),));
        }
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Verification mail has been sent to your e-mail",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              AuthButton(
                text: "Resend e-mail",
                onTap: (){
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  const snackBar = SnackBar(content: Text("E-mail resent"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
