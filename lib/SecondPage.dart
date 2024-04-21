// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() {
    return _SecondState();
  }
}

class _SecondState extends State<SecondPage> {
  String _scanResult = ""; 

  @override
  void initState() {
    super.initState();
  }

  
  Future <void> _sendAttendance(BuildContext context) async {
    // submit attendance API
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance submitted')),
      );

      setState(() {
        _scanResult = "";
      });
  }

  Future<void> _scanCode() async {
    String codeResult;
    try {
      codeResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 
        "Cancel",   
        true,      
        ScanMode.BARCODE
      );
    } on PlatformException {
      codeResult = "Unable to scan the barcode."; 
    }

  
    setState(() {
      _scanResult = codeResult.replaceAll('A','');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Barcode scanner"),),
        body: Builder(builder: (BuildContext context) {
          return Container( 
            alignment: Alignment.center,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _scanCode, 
                  child: const Text("Scan")
                ),
                _scanResult.isNotEmpty 
                  ? Text("Scan Result: $_scanResult") 
                  : const Text("Nothing scanned"),
                const SizedBox(height:30),
                ElevatedButton( 
                  onPressed: ()=> _sendAttendance(context), 
                  child: const Text("Submit attendance") 
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}


