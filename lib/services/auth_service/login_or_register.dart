import 'package:flutter/material.dart';
import 'package:tasker/pages/authentication/register.dart';

import '../../pages/authentication/login.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void toggleLoginPage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showLoginPage){
      return Login(onTextButtonTap: toggleLoginPage,);
    }else{
      return Register(onTextButtonTap: toggleLoginPage,);
    }

  }
}
