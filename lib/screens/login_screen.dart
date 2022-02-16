import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///controller for email field///
  TextEditingController emailController = TextEditingController();
  ///controller for password field///
  TextEditingController passController = TextEditingController();
  ///to show loading indicator//
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ///for creating responsive height & width values///
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
                    keyboardType: TextInputType.emailAddress,
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
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    obscuringCharacter: '#',
                    controller: passController,
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
                                } else {
                                  ///to login with email and password///
                                  User? result = await AuthService().login(
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
                                  // ignore: avoid_print
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
                                child: const Text('Login'),
                              )),
                        ),
                  SizedBox(
                    height: size.height / 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('For a new account'),
                      TextButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupScreen()),
                              (route) => false),
                          child: const Text('SignUp'))
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: size.height / 120,
                  ),
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : SignInButton(Buttons.Google,
                          text: 'Continue with Google',
                          onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          ///login with google account///
                          User? result =
                              await AuthService().googleLogin(context);
                          if (result != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen(result,)),
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
