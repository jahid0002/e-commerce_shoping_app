import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online/bloc/save_history/history_event.dart';
import 'package:online/bloc/save_history/history_state.dart';
import 'package:online/utilsh/snakbar.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';




class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(const HistoryState()) {
    on<SignleProductEvent>(_signleProductEvent); 
     on<ProductEvent>(_productEvent);
  } 

 
 final store = FirebaseFirestore.instance; 
 final email = FirebaseAuth.instance.currentUser!.email;


 void _signleProductEvent(SignleProductEvent event, Emitter<HistoryState>emit)async{ 

   try{

   await store.collection('app').doc(email).collection('history').doc(event.id).set({
       'id': event.id, 
       'name': event.title, 
       'price' : event.price, 
       'image' : event.image, 
       'count' : event.quntity,
   }).then((value) {emit(state.copyWith(totalPrice: event.price));});

   }catch(e){AppTost.showTost(title: e.toString());}
  


 } 
 void _productEvent(ProductEvent event, Emitter<HistoryState>emit)async{

Map<String, dynamic> cartData = PersistentShoppingCart().getCartData();
List<PersistentShoppingCartItem> cartItems = cartData['cartItems'];
double totalPriceFromData = cartData['totalPrice']; 
    
   if(cartItems.isNotEmpty){
  for(int i=0; i<cartItems.length; i++){ 

   try{

   await store.collection('app').doc(email).collection('history').doc(cartItems[i].productId).set({
       'id': cartItems[i].productId, 
       'name': cartItems[i].productName, 
       'price' : cartItems[i].unitPrice, 
       'image' : cartItems[i].productImages![0], 
       'count' : cartItems[i].quantity,
   }).then((value) {emit(state.copyWith(totalPrice: totalPriceFromData));});

   }catch(e){AppTost.showTost(title: e.toString());}
  

  }


   }

 }

}
