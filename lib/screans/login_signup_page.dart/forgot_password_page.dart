import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_buttons.dart';
import 'package:online/custom_widget/custom_textfield.dart';
import 'package:online/utilsh/const.dart';
import 'package:online/utilsh/snakbar.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      appBar:
          CustomAppBar.customAppBar(context: context, title: 'Forgot Password'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextField(
                controller: emailController, hintText: 'Enter your email'),
            CustomButton(
                buttonName: 'Forgot password',
                onTap: () async {
                  if (emailController.text.isNotEmpty) {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: emailController.text.trim().toString())
                        .then((value) {
                      AppName.push(
                          context: context, object: const ShowPasswordPage());
                    });
                  } else {
                    AppTost.showTost(title: 'plasse Enter your email');
                  }
                })
          ],
        ),
      ),
    );
  }
}

class ShowPasswordPage extends StatelessWidget {
  const ShowPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Chake your email')),
    );
  }
}
