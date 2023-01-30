// ignore_for_file: prefer_const_constructors

import 'package:appdemo/healthyUserPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Home",
              style: TextStyle(color: Colors.black, fontSize: 32),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: HealthyUser());
  }
}
