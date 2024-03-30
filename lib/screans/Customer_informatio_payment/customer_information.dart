

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/save_history/history_bloc.dart';
import 'package:online/bloc/save_history/history_event.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_buttons.dart';
import 'package:online/custom_widget/custom_textfield.dart';
import 'package:online/model/cart_details_model.dart';
import 'package:online/screans/Customer_informatio_payment/sucssefull_payment.dart';
import 'package:online/utilsh/color.dart';
import 'package:online/utilsh/snakbar.dart';

class CustomerInformation extends StatelessWidget { 
  const CustomerInformation({super.key,  required this.item}); 
 final CartDetailsModel item;

  @override
  Widget build(BuildContext context) {
    final presentAddressController = TextEditingController(); 
    final numberController = TextEditingController(); 
    final email = FirebaseAuth.instance.currentUser!.email; 
    final store = FirebaseFirestore.instance;
  
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context: context, title: 'Update Information'), 
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: store.collection('app').doc(email).snapshots(),
              builder: (context, snapshot) {   
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,));
                }else{ 
                    if(snapshot.data!.data()!['delivaryAddress'].toString().isNotEmpty || snapshot.data!.data()!['number'].toString().isNotEmpty){
                      presentAddressController.text = snapshot.data!.data()!['delivaryAddress'].toString(); 
                      numberController.text = snapshot.data!.data()!['number'].toString();
                    }
                    return Column(children: [ 
                    CustomTextField2(controller:presentAddressController , hintText: 'Enter your present address', title: 'Delivary Address'), 
                    const SizedBox(height: 5,), 
                     CustomTextField2(
                      keybord: TextInputType.number,
                      controller:numberController, hintText: 'Enter your number', title: 'Number'),  
                
                ],);
                }
              
              
              }
            ), 
            CustomButton(buttonName: 'Payment Method', onTap: ()async{ 
              if(presentAddressController.text.isNotEmpty && numberController.text.isNotEmpty){ 
                await store.collection('app' ).doc(email).update({
                  'delivaryAddress' : presentAddressController.text.trim(), 
                  'number': numberController.text.trim(),
                });

                  context.read<HistoryBloc>().add(SignleProductEvent(item.name, item.id.toString(), 1, double.parse(item.price), item.imagePath));
             // ignore: use_build_context_synchronously
             Navigator.push(context, MaterialPageRoute(builder: (_)=> SuccessfulyPaymentPage(item: item,)));}else{
              AppTost.showTost(title: 'Palsse update your indentity');
             }})
          ],
        ),
      )),
    );
  }











}
























class CustomerInformation2 extends StatelessWidget {
  const CustomerInformation2({super.key}); 


  @override
  Widget build(BuildContext context) {
    final presentAddressController = TextEditingController(); 
    final numberController = TextEditingController(); 
    final email = FirebaseAuth.instance.currentUser!.email; 
    final store = FirebaseFirestore.instance;
  
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context: context, title: 'Update Information'), 
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: store.collection('app').doc(email).snapshots(),
              builder: (context, snapshot) {   
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,));
                }else{ 
                    if(snapshot.data!.data()!['delivaryAddress'].toString().isNotEmpty || snapshot.data!.data()!['number'].toString().isNotEmpty){
                      presentAddressController.text = snapshot.data!.data()!['delivaryAddress'].toString(); 
                      numberController.text = snapshot.data!.data()!['number'].toString();
                    }
                    return Column(children: [ 
                    CustomTextField2(controller:presentAddressController , hintText: 'Enter your present address', title: 'Delivary Address'), 
                    const SizedBox(height: 5,), 
                     CustomTextField2(
                      keybord: TextInputType.number,
                      controller:numberController, hintText: 'Enter your number', title: 'Number'),  
                
                ],);
                }
              
              
              }
            ), 
            CustomButton(buttonName: 'Payment Method', onTap: (){ 
              if(presentAddressController.text.isNotEmpty && numberController.text.isNotEmpty){ 



           


              
              }})
          ],
        ),
      )),
    );
  }
}