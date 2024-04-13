import 'package:flutter/material.dart';
import 'package:noteapp/models/user_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.onPress});

  final VoidCallback onPress;
  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double margin = 0;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'loginFormKey');

  final User loginUser = User.empty;

  bool _isShowPassword = false;

  Future<dynamic> signIn() async => await Future.value();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.values[2],
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 60),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 39,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.values[2],
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white30),
                              suffixIcon: Icon(
                                Icons.email,
                                size: 18,
                              ),
                              contentPadding: EdgeInsets.all(10.0),
                              fillColor: Color.fromARGB(255, 50, 45, 68),
                              filled: true,
                              errorStyle: TextStyle(color: Colors.redAccent)),
                          onChanged: (value) {
                            setState(() {
                              loginUser.email = value;
                            });
                          },
                          // validator: (value) {
                          //   if (!User.isValidEmail(value!)) {
                          //     return 'Invalid email';
                          //   }
                          //   return '';
                          // }
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                            obscureText: !_isShowPassword,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle:
                                    const TextStyle(color: Colors.white30),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isShowPassword = !_isShowPassword;
                                      });
                                    },
                                    icon: Icon(
                                      _isShowPassword
                                          ? Icons.lock_open
                                          : Icons.lock,
                                      size: 18,
                                      color: _isShowPassword
                                          ? Colors.white70
                                          : Colors.white30,
                                    )),
                                fillColor:
                                    const Color.fromARGB(255, 50, 45, 68),
                                contentPadding: const EdgeInsets.all(10.0),
                                errorStyle:
                                    const TextStyle(color: Colors.redAccent),
                                filled: true),
                            onChanged: (value) {
                              setState(() {
                                loginUser.password = value;
                              });
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Please fill in password';
                            //   }
                            //   return '';
                            // },
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white70),
                            ),
                            child: const Text("Forgot Password"),
                          )),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 97, 97, 198),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                )),
                            child: const Text("Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: const Text(
                            "Or login with",
                            style: TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white30,
                                decorationThickness: 1,
                                decorationStyle: TextDecorationStyle.wavy,
                                fontSize: 15),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 40.0),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.apple,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                alignment: Alignment.center,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.g_mobiledata,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                alignment: Alignment.center,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: TextButton(
                        onPressed: () => widget.onPress(),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white70),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: widget.onPress,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white70,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white70,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ])));
  }
}
