import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fly_web/pages/medical_consultancy.dart';
import 'package:fly_web/pages/mental_health.dart';

import '../widgets/button_widget.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/sky-background.jpg'),
            fit: BoxFit.cover,
          ),

        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(50.0),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
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
                const SizedBox(height: 5.0),
                TextFormField(
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
                const SizedBox(height: 25.0),
                ButtonWidget(
                  onTap: () {
                    Navigator.of(context).pushNamed(MedicalConsultancyPage.routeName);
                  },
                  child: const Text(
                    'Aviation Authority Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                ButtonWidget(
                  onTap: () {
                    Navigator.of(context).pushNamed(MentalHealthPage.routeName);
                  },
                  child: const Text(
                    'Medical Officer Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}