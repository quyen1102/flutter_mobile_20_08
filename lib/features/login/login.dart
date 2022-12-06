import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobile_20_08/features/App.dart';
import 'package:flutter_mobile_20_08/features/Home/HomeScreen.dart';

import '../../common/theme.dart';
import '../../util/toast.dart';
import 'signUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool _currentPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _currentPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffedeff9),
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
                      child: Text("Wellcome to my app!",
                          style: TextStyle(
                            color: primaryDarkColor,
                            fontSize: 22,
                          ))),
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
                      obscureText: !_currentPasswordVisible,
                      enableSuggestions: false,
                      valid: _validPassword),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: onPressedLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 0,
                        onPrimary: Colors.white,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      child: Text("Login")),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    child: const Text("I have not a account!!!"),
                    onPressed: () => signUpAccount(),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                      foregroundColor: primaryDarkColor,
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

  Future onPressedLogin() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ));
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController!.text.trim(),
        password: passwordController!.text.trim(),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      toast("Welcome to my app!!!");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => AppContent()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMaterialDialog('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _showMaterialDialog('Wrong password provided for that user.');
      }
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
                  primary: Color.fromARGB(255, 206, 202, 12),
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
                  primary: Colors.grey,
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

  signUpAccount() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
}
