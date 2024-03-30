import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/My_Account/my_account_bloc.dart';
import 'package:online/bloc/My_Account/my_account_event.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_bottom_seet.dart';
import 'package:online/custom_widget/custom_list_tile.dart';
import 'package:online/utilsh/color.dart';
import 'package:online/utilsh/const.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({super.key, required this.dta});
  final Map<String, dynamic> dta;
  final CustomBottomSheet customBottomSheet = CustomBottomSheet();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); 
    final email = FirebaseAuth.instance.currentUser!.email; 
    final store = FirebaseFirestore.instance;
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context: context, title: 'My Account'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: store.collection('app').doc(email).snapshots(),
            builder: (context, snapshot) { 
              if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,));
              }else{ 
                final data = snapshot.data!.data();
                return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.30,
                        width: size.width * 0.50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border:
                              Border.all(width: 2, color: AppColor.backgroundColor),
                          image: data!['image'] != null
                              ? DecorationImage(
                                  image: NetworkImage(data['image']),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(AppName.imageUrl),
                                  fit: BoxFit.cover),
                        ),
                      ),
                      Positioned( 
                        right: -1, 
                        bottom: -1,
                        child: Material( 
                          color: AppColor.blackColor,
                            borderRadius: BorderRadius.circular(22),
                            clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap:() {
                              context.read<MyAccountBloc>().add(PickImageEvent(conext: context));
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColor.backgroundColor,
                              
                              radius: 22,
                              child: Icon(
                                Icons.add,
                                size: 35,
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height *0.01,),
                  Text(
                    data['email'],
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 19, color: AppColor.blackColor.withOpacity(.5)),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  CustomListTile(
                    subTitle: data['userName'],
                    leading: Icons.person_outline,
                    onTap: () {
                      customBottomSheet.bottomSheet(
                          context: context,
                          editType: 'userName',
                          editData: data['userName']);
                    },
                    title: 'User name',
                    traling: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  CustomListTile(
                    subTitle: data['profetion'],
                    leading: Icons.work_outline,
                    onTap: () {
                       customBottomSheet.bottomSheet(
                          context: context,
                          editType: 'profetion',
                          editData: data['profetion']);
                    },
                    title: 'Profesion',
                    traling: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  CustomListTile(
                    subTitle: data['blood'],
                    leading: Icons.bloodtype_outlined,
                    onTap: () {
                       customBottomSheet.bottomSheet(
                          context: context,
                          editType: 'blood',
                          editData: data['blood']);
                    },
                    title: 'Blood Group',
                    traling: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  CustomListTile(
                    subTitle: data['address'],
                    leading: Icons.location_city_outlined,
                    onTap: () { customBottomSheet.bottomSheet(
                          context: context,
                          editType: 'address',
                          editData: data['address']);},
                    title: 'Address',
                    traling: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              );
              }
             
            }
          ),
        ),
      ),
    );
  }
}
