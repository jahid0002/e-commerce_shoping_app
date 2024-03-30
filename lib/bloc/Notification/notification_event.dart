

import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable{ 

const NotificationEvent();



  @override
  List<Object?> get props => [];




} 


class GetTokenEvent extends NotificationEvent{

const GetTokenEvent();

  @override
  List<Object?> get props => [];
} 

class NotificationListenEvent extends NotificationEvent{

const NotificationListenEvent();

  @override
  List<Object?> get props => [];
}

class InitializeLocalPlagin extends NotificationEvent{

const InitializeLocalPlagin();

  @override
  List<Object?> get props => [];
}