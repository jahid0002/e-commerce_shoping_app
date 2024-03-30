import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:online/bloc/Notification/notification_event.dart';
import 'package:online/bloc/Notification/notification_state.dart';
import 'package:online/utilsh/color.dart';
import 'package:online/utilsh/snakbar.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState()) {
    on<GetTokenEvent>(_getTokenEvent);  
    on<NotificationListenEvent>(_notificationListenEvent);  
    on<InitializeLocalPlagin>(_initializeLocalPlagin);

  }

  final messages = FirebaseMessaging.instance;
  final email = FirebaseAuth.instance.currentUser!.email;
  final store = FirebaseFirestore.instance; 
   final  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



  void _getTokenEvent(GetTokenEvent event, Emitter<NotificationState> emit) async {
    String? token =await FirebaseMessaging.instance.getToken();
      // ignore: avoid_print
      print(token.toString());
    if (token.toString().isNotEmpty) {
      await store
          .collection('app')
          .doc(email)
          .update({'token': token.toString()}).then((value) { 
            emit(state.copyWith(token: token));
        AppTost.showTost( 
             
            title: 'Token Collected', color: AppColor.backgroundColor);
      }).onError((error, stackTrace) {
        AppTost.showTost(
            title: 'Token not collected', );
      });
    }
  } 

void _notificationListenEvent(NotificationListenEvent event, Emitter<NotificationState>emit)async{ 

    
    // ignore: unused_local_variable
    final setting = await messages.requestPermission(
      alert: true, 
      badge: true, 
      announcement: true, 
      carPlay: true, 
      criticalAlert: true, 
      provisional: true, 
      sound: true,
    ); 

   if(setting.authorizationStatus == AuthorizationStatus.authorized){
    // ignore: avoid_print
    print('start');
   }else if(setting.authorizationStatus == AuthorizationStatus.denied){
    // ignore: avoid_print
    print('off');
   }

  


   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle FCM message when the app is in foreground
      // ignore: avoid_print
      print("onMessage: ${message.notification?.body}"); 
       _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification when app is in background but opened by user
      // ignore: avoid_print
      print("onMessageOpenedApp: ${message.notification?.body}"); 
      _showNotification(message);
    });}   

 
  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification!.title, // Notification title
      message.notification!.body, // Notification body
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

   void _initializeLocalPlagin(InitializeLocalPlagin event, Emitter<NotificationState>emit) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


}
