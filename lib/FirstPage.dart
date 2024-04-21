// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'SecondPage.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  
  bool _checkApiStatus() {
    //api to be implemented
   return true;
  }

  Future<void> _startButtonPressed(BuildContext context) async {
    bool isSuccess = _checkApiStatus();

    if (isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SecondPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance not allowed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startButtonPressed(context),
          child: const Text('Start Attendance'),
        ),
      ),
    );
  }
}
