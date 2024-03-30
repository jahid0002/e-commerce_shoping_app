

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:online/utilsh/const.dart';

class MyAccountState extends Equatable{ 

const MyAccountState({this.imagePath, this.isSave = false, this.data, this.status = Status.loading}); 

   final File? imagePath;
   final bool isSave; 
  final QuerySnapshot<Map<String, dynamic>>? data; 
  final Status status; 
   

   MyAccountState copyWith({File? imagePath, bool? isSave, QuerySnapshot<Map<String, dynamic>>? data,  Status? status}){
    return MyAccountState(
        imagePath: imagePath?? this.imagePath, 
        isSave: isSave?? this.isSave, 
        data: data?? this.data, 
        status: status??this.status,
    );
   }


  @override
  List<Object?> get props => [imagePath, isSave];



}