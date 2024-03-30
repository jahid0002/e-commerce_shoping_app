


import 'package:equatable/equatable.dart';

abstract class AddCartEvents extends Equatable{
const AddCartEvents();

  @override
  List<Object?> get props => [];


}  

class GetTotalPrice extends AddCartEvents{

 const GetTotalPrice();  
  
  @override
  List<Object?> get props => []; 
}


class AddQuantityEvent extends AddCartEvents{

const AddQuantityEvent({required this.id, required this.quantity});    

    final int quantity; 
    final String id;
  
  @override
  List<Object?> get props => [quantity,id];
} 

// ignore: must_be_immutable
class RemoveQuantityEvent extends AddCartEvents{
 RemoveQuantityEvent({required this.id, required this.quantity}); 
  int quantity; 
    final String id;
  
  @override
  List<Object?> get props => [quantity,id];
}