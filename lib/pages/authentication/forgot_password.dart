import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/components/auth_button.dart';
import 'package:tasker/components/auth_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController forgotPasswordEmailController = TextEditingController();
  
  Future <void> forgotPassword(String email) async {
    
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try{
      await FirebaseAuth
        .instance
        .sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      const snackBar = SnackBar(content: Text("E-Mail has been sent"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if(forgotPasswordEmailController.text.isEmpty){
        const snackBar = SnackBar(content: Text("Enter email"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        const snackBar = SnackBar(content: Text("Error Occurred"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter email for password reset link",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20,),
              AuthTextField(hintText: "Enter email", controller: forgotPasswordEmailController),
              const SizedBox(height: 20,),
              AuthButton(
                text: "Send mail",
                onTap: (){
                  forgotPassword(forgotPasswordEmailController.text);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
