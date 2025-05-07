import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/components/auth_button.dart';
import 'package:tasker/components/auth_text_field.dart';
import 'package:tasker/pages/authentication/forgot_password.dart';

class Login extends StatefulWidget {

  final void Function() onTextButtonTap;

  const Login({super.key, required this.onTextButtonTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future <void> signInWithEmail(String email, String password) async {
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
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      print("Error: ${e.code}");
      Navigator.pop(context);
      if(email.isEmpty || password.isEmpty){
        const snackBar = SnackBar(content: Text("Fill all the fields"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else{
        var snackBar = SnackBar(content: Text("Error: ${e.code}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
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
              const Icon(
                Icons.add_task_sharp,
                size: 120,
              ),
              const Text(
                "Tasker",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 40,),
              AuthTextField(
                hintText: "Enter e-mail",
                controller: emailController
              ),
              const SizedBox(height: 18,),
              AuthTextField(
                  hintText: "Enter password",
                  controller: passwordController
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                    },
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),
                    )
                  )
                ],
              ),
              const SizedBox(height: 30,),
              AuthButton(
                text: "Login",
                onTap: (){
                  signInWithEmail(emailController.text, passwordController.text);
                }
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onTextButtonTap,
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
