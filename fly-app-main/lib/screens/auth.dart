// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/screens/capture_me.dart';
import 'package:fly_app/screens/register.dart';
import 'package:fly_app/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'register.dart';

import '../controllers/auth_controller.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  get firebaseAuth => null;

  Future readDataAndSetDataLocally(User currentUser) async {
    final bool status = await _authController.checkUser(currentUser.uid);
    if (status) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (e) => const CaptureMe()));
    } else {
      firebaseAuth.signOut();
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (e) => const AuthScreen()));
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message:
                  "Account does not exist, Plase enter a valid username and password",
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(
            message: "Checking credentials",
          );
        });

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  validateUser() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please provide both username and password",
            );
          });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15.0),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sky-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Safe Navigation',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Username",
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Password",
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ButtonWidget(
                    onTap: () {
                      Navigator.of(context).pushNamed(CaptureMe.routeName);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  ButtonWidget(
                    onTap: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
