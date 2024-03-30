import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/nav_bar/navbar_bloc.dart';
import 'package:online/bloc/nav_bar/navbar_state.dart';
import 'package:online/bloc/nav_bar/navebar_event.dart';
import 'package:online/utilsh/color.dart';

class NavePage extends StatefulWidget {
  const NavePage({super.key});

  @override
  State<NavePage> createState() => _NavePageState();
}

class _NavePageState extends State<NavePage> { 

 @override
  void initState() {
 
    super.initState(); 
 context.read<NavBarBloc>().add(const ConnectivityEvent());


  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        if(!state.isConnectivity){
          return Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,));
        }else{
      return Scaffold(body:
            BlocBuilder<NavBarBloc, NavBarState>(builder: (context, state) {
          return state.page[state.index];
        }), bottomNavigationBar: BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.0, left: 1),
              child: BottomNavigationBar(
                  landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                  useLegacyColorScheme: false,
                  elevation: 0,
                  backgroundColor: AppColor.backgroundColor.withOpacity(.1),
                  currentIndex: state.index,
                  onTap: (value) {
                    context.read<NavBarBloc>().add(CurrentIndexEvent(
                        updateIndex: value, context: context));
                  },
                  selectedIconTheme: IconThemeData(
                    color: AppColor.backgroundColor,
                    size: 35,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: AppColor.gColor,
                    size: 30,
                  ),
                  selectedFontSize: 0,
                  selectedItemColor: AppColor.backgroundColor,
                  unselectedFontSize: 0,
                  items: const [
                    BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.home,
                        ),
                        icon: Icon(
                          Icons.home_outlined,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.favorite,
                        ),
                        icon: Icon(
                          Icons.favorite_outline,
                        ),
                        label: 'Wish List'),
                    BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.shopping_cart,
                        ),
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                        ),
                        label: 'Cart'),
                    BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.account_circle,
                        ),
                        icon: Icon(
                          Icons.account_circle_outlined,
                        ),
                        label: 'Profile'),
                  ]),
            );
          },
        ));
        }
       
      },
    );
  }
}
