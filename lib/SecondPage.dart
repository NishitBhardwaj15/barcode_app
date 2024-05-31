// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_barcode/constant.dart';
//import 'package:flutter_application_barcode/global/mysnackbar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    Future<int> scanCode() async {
      String codeResult;
      try {
        codeResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666",
          "Cancel",
          true,
          ScanMode.BARCODE,
        );
      } on PlatformException {
        codeResult = "Unable to scan the barcode.";
      }

      setState(() {
        _scanResult = codeResult.replaceAll('A', '');
      });

      const String submitStudentAttendnaceUrl = "$baseApi/attendance/publish";
      final Map<String, String> data = {"studentID": _scanResult};

      final result = await http.post(
        Uri.parse(submitStudentAttendnaceUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      final int statusCode = result.statusCode;

      return statusCode;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Barcode scanner"),
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      scanCode().then((code) {
                        if (code == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text("Attendance submitted successfully"),
                                ],
                              )
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text("Duplicate attendance submitted"),
                                ],
                              )
                            ),
                          );
                        }
                      });
                    },
                    child: const Text("Scan barcode")),
                _scanResult.isNotEmpty
                    ? Text("Scan Result: $_scanResult")
                    : const Text("Nothing scanned"),
                const SizedBox(height: 30),
              ],
            ),
          );
        }),
      ),
    );
  }
}
