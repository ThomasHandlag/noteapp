import 'package:flutter/material.dart';
import 'package:noteapp/models/user_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  double margin = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: 'loginFormKey');

  final User loginUser = User.logInUser(email: '', password: '');
 
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                    labelText: "Email",
                    suffixIcon: Icon(Icons.email)),
                onChanged: (value) {
                  setState(() {
                    loginUser.email = value;
                  });
                },
                validator: (value) {
                  if (!User.isValidEmail(value!)) {
                    return 'Invalid email';
                  }
                  return '';
                }
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    labelText: "Password",
                    suffixIcon: Icon(Icons.lock)),
                onChanged: (value) {
                  setState(() {
                    loginUser.password = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill in password';
                  }
                  return '';
                },
              ),
            ])));
  }
}
