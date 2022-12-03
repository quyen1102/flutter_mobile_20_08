import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../common/theme.dart';
import '../login/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout_outlined, color: Colors.white),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                }),
          ],
        ),
        body: Container());
  }
}
