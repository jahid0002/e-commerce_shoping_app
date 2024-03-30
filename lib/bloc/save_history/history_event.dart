


import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable{ 
const HistoryEvent();



  @override
  List<Object?> get props => [];
 }
 


 class SignleProductEvent extends HistoryEvent{
  const SignleProductEvent(this.title, this.id, this.quntity, this.price, this.image); 

    final String title; 
    final String id; 
    final int quntity; 
    final double price; 
    final String image; 





  
  @override
  List<Object?> get props => [title, id, quntity, price, image];
 } 


 class ProductEvent extends HistoryEvent{
const ProductEvent();


  

  @override
  List<Object?> get props => [];
 }