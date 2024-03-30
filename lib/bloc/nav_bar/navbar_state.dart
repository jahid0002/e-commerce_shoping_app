import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online/screans/Cart_page/cart_page.dart';
import 'package:online/screans/home/home_page.dart';
import 'package:online/screans/profile/profile_page.dart';
import 'package:online/screans/wish_list/wish_list_page.dart';

class NavBarState extends Equatable {
  final List<Widget> page = [
    const HomePage(),
    const WishListPage(),
    const CartPage(),
    const ProfilePage(),
  ]; 
   final bool isConnectivity;
  final int index; 
  NavBarState({this.index = 0, this.isConnectivity = false}); 

  NavBarState copyWith({int? index, bool? isConnectivity}){
    return NavBarState(
      index: index?? this.index, 
      isConnectivity: isConnectivity?? this.isConnectivity,
    );
  }


  @override
  List<Object?> get props => [page, index];
}
