

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MyAccountEvents extends Equatable{ 
  const MyAccountEvents();


  @override
  List<Object?> get props => [];

} 


class PickImageEvent extends MyAccountEvents{ 
  final BuildContext conext;
 const PickImageEvent({required this.conext});
  @override
  List<Object?> get props => [conext];
} 

class SaveImageEvent extends MyAccountEvents{
  const SaveImageEvent({required this.context}); 
  final BuildContext context;
   @override
  List<Object?> get props => [context];
} 

class GetHistory extends MyAccountEvents{
  const GetHistory(); 
 
   @override
  List<Object?> get props => [];
}