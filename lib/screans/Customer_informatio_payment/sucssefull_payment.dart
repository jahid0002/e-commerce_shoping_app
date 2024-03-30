


import 'package:flutter/material.dart';
import 'package:online/custom_widget/custom_buttons.dart';
import 'package:online/model/cart_details_model.dart';
import 'package:online/screans/nav_page.dart/nave_page.dart';
import 'package:online/service/notification_service/notification_service.dart';

class SuccessfulyPaymentPage extends StatefulWidget {
  const SuccessfulyPaymentPage({super.key, required this.item}); 
  final CartDetailsModel item;

  @override
  State<SuccessfulyPaymentPage> createState() => _SuccessfulyPaymentPageState();
}

class _SuccessfulyPaymentPageState extends State<SuccessfulyPaymentPage> {  


             


  final service = NotificationService(); 



  @override
  void initState() {
  
    super.initState(); 

    service.sendNotification(title: 'Conratulation', body: 'Your product in the way\nprice: \$ ${widget.item.price}\nname: ${widget.item.name}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
        
          children: [ 
                Column(children: [ 
                    Text('Congratulation', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),), 
                   Text('Your oder confirm', style: Theme.of(context).textTheme.headlineMedium,), 
                   Text('\$ ${widget.item.price}', style: Theme.of(context).textTheme.displayMedium,), 
                ],), 
                const SizedBox(height: 20,),
        
                   CustomButton(buttonName: 'Continue Shopping', onTap:() {
                   

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const NavePage()));
              
                      
                   }),
                  
          ],
        ),
      ),),
    );
  }
}