

import 'package:equatable/equatable.dart';

class NotificationState extends Equatable{ 

const NotificationState({this.token = ''});

 final String token ;

 
NotificationState copyWith({String? token}){return NotificationState(token: token?? this.token);}

  
  @override
  List<Object?> get props => [token];




}