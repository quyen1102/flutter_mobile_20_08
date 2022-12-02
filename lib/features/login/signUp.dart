import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobile_20_08/features/login/login.dart';

import '../../common/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  bool _currentPasswordVisible = true;
  bool _currentConfirmPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _currentPasswordVisible = false;
    _currentConfirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 164, 114, 192),
        ),
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: primaryLightColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 20),
                  _renderTextInput(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autoCorrect: true,
                      labelText: "Enter your email address",
                      obscureText: false,
                      enableSuggestions: true,
                      valid: _validMail),
                  _renderTextInput(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      autoCorrect: false,
                      labelText: "Password",
                      obscureText: true,
                      enableSuggestions: false,
                      valid: _validPassword),
                  _renderTextInput(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      autoCorrect: false,
                      labelText: "Confirm Password",
                      obscureText: true,
                      enableSuggestions: false,
                      valid: _validPassword),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: onPressedSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 232, 209, 63),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 0,
                        onPrimary: primaryDarkColor,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      child: Text("Sign Up")),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    child: const Text("Login"),
                    onPressed: () => _gotoLogin(),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                      foregroundColor: primaryLightColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  _renderTextInput(
      {controller,
      keyboardType,
      autoCorrect,
      labelText,
      obscureText,
      enableSuggestions,
      valid}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        enableSuggestions: enableSuggestions,
        obscureText: obscureText,
        keyboardType: keyboardType,
        autocorrect: autoCorrect,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
            // labelText: labelText,
            // labelStyle: const TextStyle(color: Colors.black54),
            hintStyle: const TextStyle(fontSize: 14),
            hintText: labelText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            focusColor: primaryLightColor,
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gapPadding: 1.0,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gapPadding: 4.0,
            ),
            suffixIcon: obscureText
                ? IconButton(
                    icon: Icon(
                        _currentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                        size: 20),
                    onPressed: () {
                      setState(() {
                        _currentPasswordVisible = !_currentPasswordVisible;
                      });
                    },
                  )
                : null),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: valid,
      ),
    );
  }

  String? _validMail(String? value) {
    if (value!.isEmpty) {
      return null;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Email incorrect form abc@def.xyz !';
    } else {
      return null;
    }
  }

  String? _validPassword(String? value) {
    if (value!.isEmpty) {
      return null;
    } else if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
        .hasMatch(value)) {
      return "Minimum eight characters, at least one letter and one number!";
    } else {
      return null;
    }
  }

  Future onPressedSignUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ));
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController!.text.trim(),
        password: passwordController!.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showMaterialDialog('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showMaterialDialog('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController!.text.trim(),
    //     password: passwordController!.text.trim());
  }

  void _showMaterialDialog(content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Something went wrong'),
            content: Text(content!.toString()),
            elevation: 30.0,
            backgroundColor: primaryColor,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 58, 239, 255),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    emailController = TextEditingController();
                    passwordController = TextEditingController();
                  });
                },
                child: const Text(
                  'Retyping',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 149, 33, 33),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          );
        });
  }

  _gotoLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}
