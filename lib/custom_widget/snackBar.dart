import 'package:flutter/material.dart';

  snackBar(BuildContext context , String message){
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(content: Text(message)));
  }