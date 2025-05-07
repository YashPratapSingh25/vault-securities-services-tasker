import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/auth_button.dart';
import '../../components/auth_text_field.dart';

class Register extends StatefulWidget {

  final void Function()? onTextButtonTap;

  const Register({super.key, this.onTextButtonTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future <void> createUserWithEmail(String email, String password, String name) async {

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
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
      if(email.isEmpty || password.isEmpty || name.isEmpty){
        const snackBar = SnackBar(content: Text("Fill all the fields"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        var snackBar = SnackBar(content: Text("Error: ${e.code}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

  }

  Future <void> sendEmailVerificationLink() async {

    try{
      await FirebaseAuth
          .instance
          .currentUser
          ?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
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
              const SizedBox(height: 18,),
              AuthTextField(
                hintText: "Enter name",
                controller: nameController
              ),
              const SizedBox(height: 30,),
              AuthButton(
                  text: "Register",
                  onTap: (){
                    createUserWithEmail(emailController.text, passwordController.text, nameController.text);
                  }
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ?",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  TextButton(
                      onPressed: widget.onTextButtonTap,
                      child: const Text(
                        "Login here",
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
