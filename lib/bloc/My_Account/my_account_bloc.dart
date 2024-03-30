import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online/bloc/My_Account/my_account_event.dart';
import 'package:online/bloc/My_Account/my_account_state.dart';
import 'package:online/screans/profile/select_image_page.dart';
import 'package:online/utilsh/const.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyAccountBloc extends Bloc<MyAccountEvents, MyAccountState> {
  MyAccountBloc() : super(const MyAccountState()) {
    on<PickImageEvent>(_pickImageEvent);
    on<SaveImageEvent>(_saveImageEvent); 
     on<GetHistory>(_getHistory);
  }

  void _pickImageEvent(
      PickImageEvent event, Emitter<MyAccountState> emit) async {
    File? imagePath;

    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      // ignore: unnecessary_null_comparison
      if (imagePath == null) {
        imagePath = File(pickImage.path);
        emit(state.copyWith(imagePath: imagePath));
        // ignore: use_build_context_synchronously
        AppName.pushReplacement(
            // ignore: use_build_context_synchronously
            context: event.conext, object: const PickImage());
      } else {
        imagePath = File(pickImage.path);
        emit(state.copyWith(imagePath: imagePath));
        AppName.pushReplacement(
            // ignore: use_build_context_synchronously
            context: event.conext, object: const PickImage());
      }
    }
  }

  void _saveImageEvent(
      SaveImageEvent event, Emitter<MyAccountState> emit) async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final storge = FirebaseStorage.instance
        // ignore: prefer_interpolation_to_compose_strings
        .ref('/image' + DateTime.now().microsecondsSinceEpoch.toString());
       
        final store = FirebaseFirestore.instance;

 
     if(state.imagePath != null){  

      emit(state.copyWith(isSave: true));

   final uploadFile = await storge.putFile(state.imagePath!.absolute);  

    await Future.value(uploadFile).then((value)async {
          String? newUrl = await storge.getDownloadURL(); 

        if(newUrl.isNotEmpty){
            await store.collection('app').doc(email).update({
            'image' : newUrl
          }).then((value) {
            emit(state.copyWith(isSave: false));
           showTopSnackBar(
    Overlay.of(event.context),
    const CustomSnackBar.success(
      message:
          "Your profile picture change successfully",
    ), 
   
); Navigator.pop(event.context);
          }).onError((error, stackTrace) { 
            emit(state.copyWith(isSave: false));
            showTopSnackBar(
    Overlay.of(event.context),
    const CustomSnackBar.success(
      message:'Firebase Firestore not save this image',
    ),
);
          });
        }else{
           emit(state.copyWith(isSave: false));
 showTopSnackBar( 
    // ignore: use_build_context_synchronously
    Overlay.of(event.context),
    const CustomSnackBar.success(
      message:
          "New Url Empty",
    ),
);
        }

    }).onError((error, stackTrace) { 
      emit(state.copyWith(isSave: false));
            showTopSnackBar(
    Overlay.of(event.context),
    const CustomSnackBar.success(
      message:'Firebase Storage not save this image',
    ),
);
          });
     

     }


  } 




  void _getHistory(GetHistory event, Emitter<MyAccountState>emit)async{ 

    

     final email = FirebaseAuth.instance.currentUser!.email; 
  final store  = FirebaseFirestore.instance; 
     


     final data =  await store.collection('app').doc(email).collection('history').get(); 

     if(data.docs.isEmpty){
      emit(state.copyWith(data: data, status:  Status.fail)); 
      if (kDebugMode) {
        print('empty');
      }
     }else{
        emit(state.copyWith(data: data, status:  Status.success)); 
         if (kDebugMode) {
           print('not empty');
         }
     }


  }
}
