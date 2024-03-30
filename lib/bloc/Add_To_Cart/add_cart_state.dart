


import 'package:equatable/equatable.dart';

class AddCartState extends Equatable{
   

   const AddCartState({this.totalPrice = 0});

   final double totalPrice; 



   AddCartState copyWith({
      double? totalPrice

   }){return AddCartState(
    totalPrice: totalPrice?? this.totalPrice,
   );}
   

  @override
  List<Object?> get props => [totalPrice];



}