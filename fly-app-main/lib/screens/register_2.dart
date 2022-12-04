import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/screens/auth.dart';
import 'package:fly_app/screens/profile.dart';
import 'package:fly_app/screens/register.dart';
import 'package:fly_app/screens/results.dart';
import 'package:fly_app/widgets/button_widget.dart';
import 'package:fly_app/widgets/error_dialog.dart';
import '../models/user_two.dart';

class RegisterTwo extends StatefulWidget {
  static const routeName = '/registerTwo';
  const RegisterTwo({super.key});

  @override
  State<RegisterTwo> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<RegisterTwo> {
  GlobalKey<FormState>? _formKey;
  User_two? _user;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();

  void _submit() {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();

      // Navigator.of(context)
      //     .pushNamed(ProfileScreen.routeName, arguments: _user);
      Navigator.of(context).pushNamed(AuthScreen.routeName);
    }
  }

  Future<void> formValidation() async {
    if (passwordController.text == conpasswordController.text) {
      //password valiation is done

      if (passwordController.text.isEmpty ||
          conpasswordController.text.isEmpty ||
          emailController.text.isEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                  message: "All the fields are required for registration!");
            });
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AuthScreen()));
      }

      // showDialog(
      //     context: context,
      //     builder: (c) {
      //       return ErrorDialog(message: "Registeration is completed!");
      //     });
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Passwords do not match!");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF21517C),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          TextFormField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onSaved: (value) => _user!.userName = value,
                            validator: (value) =>
                                value!.isEmpty ? 'Username is required' : null,
                            decoration: const InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            controller: passwordController,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onSaved: (value) => _user!.password = value,
                            validator: (value) =>
                                value!.isEmpty ? 'Password is required' : null,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            controller: conpasswordController,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onSaved: (value) => _user!.conpassword = value,
                            validator: (value) => value!.isEmpty
                                ? 'Confirmation is required'
                                : null,
                            decoration: const InputDecoration(
                              labelText: "Confirm password",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ButtonWidget(
                            onTap: () {
                              formValidation();
                            },

                            // onTap: _submit,
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ])))));
  }
}
