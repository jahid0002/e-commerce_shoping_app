

import 'package:flutter/material.dart';
import 'package:online/utilsh/const.dart';

class AppNameLogo extends StatelessWidget {
  const AppNameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
             
               children: [
                ClipRRect( 
                  borderRadius: BorderRadius.circular(30), 
                   child: Image.asset(AppName.appLogo, height: 50, width: 50,)),
                 Text(AppName.appName, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24),),
               ],
             );
  }
} 

class AppNameLogoS extends StatelessWidget {
  const AppNameLogoS({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                ClipRRect( 
                  borderRadius: BorderRadius.circular(30), 
                   child: Image.asset(AppName.appLogo, height: 50, width: 50,)),
                 Text(AppName.appName, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24),),
               ],
             );
  }
}