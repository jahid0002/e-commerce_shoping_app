import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/nav_bar/navbar_bloc.dart';
import 'package:online/bloc/nav_bar/navebar_event.dart';
import 'package:online/custom_widget/custom_textfield.dart';
import 'package:online/utilsh/color.dart';

class CustomBottomSheet {
  final email = FirebaseAuth.instance.currentUser!.email;
  final store = FirebaseFirestore.instance;
  bottomSheet(
      {required BuildContext context,
      required String editType,
      required String editData}) {
    // final size = MediaQuery.sizeOf(context);
    final editController = TextEditingController();

    editController.text = editData;

    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Edit your $editType',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            content: CustomTextField(
                controller: editController, hintText: 'Enter your $editType'),
            actions: [
              Material(
                  clipBehavior: Clip.hardEdge,
                  color: AppColor.backgroundColor,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, top: 8, right: 12, left: 12),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  )),
              Material(
                  clipBehavior: Clip.hardEdge,
                  color: AppColor.backgroundColor,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () async{  

                      await store.collection('app').doc(email).update({
                        editType : editController.text.trim().toString(),
                      }).then((value) {
                        Navigator.pop(context); 
                        editController.clear(); 
                      context.read<NavBarBloc>().add(CurrentIndexEvent(updateIndex: 3, context: context));
                      });
                     
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, top: 8, right: 12, left: 12),
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  void savedata(
      {required String editController,
      required String editType,
      required String editData,
      required BuildContext context}) async {
    if (editController.isNotEmpty) {
      await store.collection('app').doc(email).update({
        editType: editController,
      }).then((value) {
        Navigator.pop(context);
      });
    }
  }
}
