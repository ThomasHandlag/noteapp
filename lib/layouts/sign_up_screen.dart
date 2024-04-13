import 'package:flutter/material.dart';
import 'package:noteapp/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onPress});
  final VoidCallback onPress;
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String passwordValidationText = "";

  int passwordStrength = 0;

  bool _isShowPassword = false;
  bool _isChecked = false;

  List<Color> passwordValidationColors = [
    Colors.red,
    Colors.orange,
    Colors.green
  ];

  double margin = 0;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'loginFormKey');

  final User loginUser = User.empty;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(5.0),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.values[2],
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 39,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none),
                          hintText: "User name",
                          hintStyle: TextStyle(
                            color: Colors.white30,
                          ),
                          suffixIcon: Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.white30,
                          ),
                          fillColor: Color.fromARGB(255, 50, 45, 68),
                          filled: true,
                          contentPadding: EdgeInsets.all(10)),
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white30,
                          ),
                          suffixIcon: Icon(Icons.email,
                              size: 18, color: Colors.white30),
                          fillColor: Color.fromARGB(255, 50, 45, 68),
                          filled: true,
                          contentPadding: EdgeInsets.all(10)),
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
                    margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color.fromARGB(255, 50, 45, 68),
                          hintStyle: const TextStyle(
                            color: Colors.white30,
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isShowPassword = !_isShowPassword;
                              });
                            },
                            icon: Icon(
                              _isShowPassword ? Icons.lock_open : Icons.lock,
                              size: 18,
                              color: _isShowPassword
                                  ? Colors.white70
                                  : Colors.white30,
                            ),
                          )),
                      onChanged: (value) {
                        setState(() {
                          loginUser.password = value;
                        });
                      },
                      obscureText: !_isShowPassword,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please fill in password';
                      //   }
                      //   return '';
                      // },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          tristate: true,
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value != null ? true : false;
                            });
                          },
                        ),
                        const Text(
                          "You agree to our",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Terms and conditions",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white70,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _isChecked
                                ? const Color.fromARGB(255, 97, 97, 198)
                                : const Color.fromARGB(255, 50, 45, 68),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: const Text("Sign up",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "Or",
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
                      )),
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
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: widget.onPress,
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
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

  // Text(passwordValidationText, style: TextStyle(
  //               color: passwordValidationColors[passwordStrength]
  //             ),),