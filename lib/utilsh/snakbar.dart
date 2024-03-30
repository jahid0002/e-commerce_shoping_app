
import 'package:flutter/material.dart'; 
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online/utilsh/color.dart';

class AppTost{

 static void showTost({required String title, Color? color}){
     Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: color?? AppColor.errorColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}