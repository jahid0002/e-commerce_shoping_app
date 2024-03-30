import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/home/home_bloc.dart';
import 'package:online/bloc/home/home_state.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_category.dart';
import 'package:online/screans/home/catagory_details.dart';
import 'package:online/utilsh/const.dart';

class CategorySeeAllPage extends StatelessWidget {
  const CategorySeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context: context, title: 'All Cetagory'),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
                      itemCount: state.categoryList.length,
                  itemBuilder: (context, index) {return CustomCategory(
                                    imagePath: AppName.categoryImageUrlList[index],
                                    onTap: () {
                                      AppName.push(
                                          context: context,
                                          object: Categorydetails(
                                              category: state.categoryList[index]));
                                    },
                                  );}),
            ),
          );
        },
      ),
    );
  }
}
