

 import 'package:equatable/equatable.dart';

class HistoryState extends Equatable { 
const HistoryState({this.totalPrice = 0});


   final double totalPrice; 
  

HistoryState copyWith({double? totalPrice}){return HistoryState(totalPrice: totalPrice?? this.totalPrice);}    

   


  @override
  List<Object?> get props => [];
 }


 