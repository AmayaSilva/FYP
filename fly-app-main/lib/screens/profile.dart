import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fly_app/screens/capture_me.dart';
import 'package:fly_app/screens/records.dart';
import 'package:fly_app/widgets/button_widget.dart';

import '../models/user_two.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  final User_two? user;

  const ProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    user != null ? user!.name.toString() : "[ATCO's Name]",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: user != null
                        ? FileImage(File(user!.imageURL!)) as ImageProvider
                        : const AssetImage('assets/images/profile-picture.png'),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Text(
                user != null ? user!.name.toString() : "[ATCO license ID]",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                user != null ? user!.tower.toString() : "[Tower]",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                user != null ? user!.contactNo.toString() : "[Contact Number]",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              ButtonWidget(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                onTap: () {
                  Navigator.pushNamed(context, CaptureMe.routeName);
                },
                child: const Text(
                  "Check Suitability",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                onTap: () {
                  Navigator.pushNamed(context, RecordsScreen.routeName);
                },
                child: const Text(
                  "View past records",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
