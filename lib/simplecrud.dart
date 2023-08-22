import 'package:firebase_demo_1/firebase_api_services.dart';
import 'package:flutter/material.dart';

class SimpleCrudDemo extends StatefulWidget {
  const SimpleCrudDemo({super.key});

  @override
  State<SimpleCrudDemo> createState() => _SimpleCrudDemoState();
}

class _SimpleCrudDemoState extends State<SimpleCrudDemo> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          MaterialButton(
            onPressed: () {
              FirebaseApi.addUser(userName: nameController.text);
            },
            child: const Text('submit'),
          ),
        ],
      ),
    );
  }
}
