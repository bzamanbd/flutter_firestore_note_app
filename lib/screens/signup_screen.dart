// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ///controller for email field///
  TextEditingController emailController = TextEditingController();
  ///controller for password field///
  TextEditingController passController = TextEditingController();
  ///controller for confirm password field///
  TextEditingController cnfPassController = TextEditingController();
  ///to show loading indicator//
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    ///for creating responsive height & width values///
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width / 15,
                vertical: 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      hintText: 'Enter Email Address',
                      border: OutlineInputBorder(),
                    ),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      hintText: 'Enter a password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Confirm Password'),
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: cnfPassController,
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (emailController.text == "" ||
                                    passController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('All fields are required')));
                                } else if (passController.text !=
                                    cnfPassController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("password didn't match")));
                                } else {
                                  ///to register user with email and password///
                                  User? result = await AuthService().register(
                                      emailController.text,
                                      passController.text,
                                      context);
                                  if (result != null) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                HomeScreen(result)),
                                        (route) => false);
                                  }
                                  // print('success');
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height / 30,
                                  horizontal: 0,
                                ),
                                child: const Text('SignUp'),
                              )),
                        ),
                  SizedBox(
                    height: size.height / 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                              (route) => false),
                          child: const Text('Login'))
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: size.height / 120,
                  ),
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : SignInButton(Buttons.Google,
                          text: 'Continue with Google', onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          ///to login using google account///
                          User? result =
                              await AuthService().googleLogin(context);
                          if (result != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen(result)),
                                (route) => false);
                          }
                          setState(() {
                            loading = false;
                          });
                        })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
