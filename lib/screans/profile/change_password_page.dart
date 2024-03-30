import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_buttons.dart';
import 'package:online/custom_widget/custom_textfield.dart';
import 'package:online/screans/nav_page.dart/nave_page.dart';
import 'package:online/utilsh/color.dart';
import 'package:online/utilsh/const.dart';
import 'package:online/utilsh/snakbar.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final oldController = TextEditingController();
    final newOneController = TextEditingController();
    final newTwoController = TextEditingController();

    return Scaffold(
      appBar:
          CustomAppBar.customAppBar(context: context, title: 'CHange Password'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('app')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.backgroundColor,
                ));
              } else {
                final data = snapshot.data!.data();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomTextField(
                            controller: oldController,
                            hintText: 'Enter your old password'),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            controller: newOneController,
                            hintText: 'Enter your new password'),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            controller: newTwoController,
                            hintText: 'Re-Enter your new password'),
                      ],
                    ),
                    CustomButton(
                        buttonName: 'Confirm Change Password',
                        onTap: () async {
                          if (oldController.text.isNotEmpty &&
                              newTwoController.text.isNotEmpty &&
                              newOneController.text.isNotEmpty) {
                            if (newOneController.text == newTwoController.text) {
                              if (oldController.text == data!['password']) {
                                await FirebaseAuth.instance.currentUser!
                                    .updatePassword(
                                        newTwoController.text.trim().toString())
                                    .then((value) async {
                                  FirebaseFirestore.instance
                                      .collection('app')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .update({
                                    'password':
                                        newTwoController.text.trim().toString(),
                                  });

                                  AppTost.showTost(
                                      title: 'Password change seccessfully');
                                  AppName.pushReplacement(
                                      context: context,
                                      object: const NavePage());
                                });
                              } else {
                                AppTost.showTost(
                                    title:
                                        'Your old password incorrect\n plasse try again');
                              }
                            } else {
                              AppTost.showTost(title: 'Password not matching');
                            }
                            
                          } else if (oldController.text.isEmpty) {
                            AppTost.showTost(
                                title: 'Plasse enter your old password');
                          } else if (newOneController.text.isEmpty) {
                            AppTost.showTost(
                                title: 'Plasse enter your new password');
                          } else {
                            AppTost.showTost(
                                title: 'Plasse enter your new password');
                          }
                        })
                  ],
                );
              }
            }),
      ),
    );
  }
}
