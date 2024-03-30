


import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:online/utilsh/snakbar.dart';

class NotificationService{

    
    Future<void> sendNotification({
     
      required String title, 
      required String body, 
    } )async{

      const serverKey = 'AAAAd_Kmh9A:APA91bF7BZ5Y9ZvGGVB7_kIQivgeBWHSWGH4FfGFDNFIcsRb8OEgZOLb6EFHtb3ZqYjxz4RPa9IsX3-hABqeD0IKQ6A8pWxBSnalyg9-CIUm7cFf8D1LfTS-SdVn3BPsoEdx887APDv9';
     
    
//notification pyload
final token = await FirebaseMessaging.instance.getToken();
Map<String, dynamic> notification = {
  'title' : title, 
  'body': body, 
  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
};
  
  Map<String, dynamic>message ={
    'notification': notification, 
    'to':token,
  };

    try{
      http.Response response =await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(message),
      
      ); 
      if(response.statusCode == 200){
        // ignore: avoid_print
        print('Notification done');
      }
    }catch(e){
      AppTost.showTost(title: e.toString());
    }


    }

      
   


}