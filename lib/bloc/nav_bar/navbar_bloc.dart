

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/nav_bar/navbar_state.dart';
import 'package:online/bloc/nav_bar/navebar_event.dart';

class NavBarBloc extends Bloc<NaveBarEvent, NavBarState>{
    NavBarBloc():super(NavBarState()){
      on<CurrentIndexEvent>(_currentIndexEvent); 
      on<ConnectivityEvent>(_connectivityEvent);
    }  


    void _currentIndexEvent(CurrentIndexEvent event, Emitter<NavBarState>emit){
      emit(state.copyWith(index: event.updateIndex)); 
      
    }
   void _connectivityEvent(ConnectivityEvent event, Emitter<NavBarState>emit)async{
      

      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
       if (connectivityResult.contains(ConnectivityResult.mobile)){
          emit(state.copyWith(isConnectivity: true));
       }else if(connectivityResult.contains(ConnectivityResult.wifi)){
          emit(state.copyWith(isConnectivity: true));
       }else{
        emit(state.copyWith(isConnectivity: false));
       }

   }
}