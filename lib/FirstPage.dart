// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_barcode/constant.dart';
import 'package:flutter_application_barcode/global/mysnackbar.dart';
import 'package:flutter_application_barcode/global/next_screen.dart';
import 'SecondPage.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

   
  @override
  Widget build(BuildContext context) {


goToNextScreen(){
  nextScreen(context, const SecondPage());
}

handleErrorMessagesWithNumber(int statusReceived){
  mySnackbar(context, errorMessages[statusReceived]!);
}

handleErrorMessages(String message){
  mySnackbar(context, message);
}




 Future<void> startButtonPressed() async {

      const String startAttendanceURL="$baseApi/attendance/getTakingAttendance";

   try{
     final response = await http.get(
      Uri.parse(startAttendanceURL),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
      );

    final statusCode=response.statusCode;
    print(response.statusCode);
    print(jsonDecode(response.body));

    if (statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (jsonResponse['takingAttendance'] == true)
       { 
        goToNextScreen(); 
      }else{
        handleErrorMessagesWithNumber(700);
      }
    } 
     else if(statusCode==403){
        handleErrorMessagesWithNumber(403);
        //Logout the juser
      }
      else{
        handleErrorMessagesWithNumber(statusCode);
      }
   }catch(error){
    print(error);
    handleErrorMessages(error.toString());
   }
  }
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => startButtonPressed(),
          child: const Text('Start Attendance'),
        ),
      ),
    );
  }
}