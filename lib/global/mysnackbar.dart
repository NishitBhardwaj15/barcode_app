import 'package:flutter/material.dart';

mySnackbar(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar( 
    SnackBar(content: Text(message),duration: const Duration(seconds: 2),action: SnackBarAction(label: "Ok", onPressed: (){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }),)
  );
}