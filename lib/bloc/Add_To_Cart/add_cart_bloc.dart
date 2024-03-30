

import 'package:bloc/bloc.dart';
import 'package:online/bloc/Add_To_Cart/add_cart_event.dart';
import 'package:online/bloc/Add_To_Cart/add_cart_state.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class AddCartBloc extends Bloc<AddCartEvents, AddCartState>{
   
   AddCartBloc():super(const AddCartState()){
    on<GetTotalPrice>(_getTotalPrice); 
    on<AddQuantityEvent>(_addQuantityEvent); 
    on<RemoveQuantityEvent>(_removeQuantityEvent);
   }

void _getTotalPrice(GetTotalPrice event, Emitter<AddCartState>emit)async{

      double totalPrice = PersistentShoppingCart().calculateTotalPrice(); 

      emit(state.copyWith(totalPrice: totalPrice));

}  

void _addQuantityEvent(AddQuantityEvent event, Emitter<AddCartState>emit)async{


         await PersistentShoppingCart().incrementCartItemQuantity(event.id); 

         double totalPrice = PersistentShoppingCart().calculateTotalPrice(); 

      emit(state.copyWith(totalPrice: totalPrice));





} 
void _removeQuantityEvent(RemoveQuantityEvent event, Emitter<AddCartState>emit)async{
    await PersistentShoppingCart().decrementCartItemQuantity(event.id);
      double totalPrice = PersistentShoppingCart().calculateTotalPrice(); 

      emit(state.copyWith(totalPrice: totalPrice));
}


    


}