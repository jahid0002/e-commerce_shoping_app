import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/home/home_bloc.dart';
import 'package:online/bloc/home/home_state.dart';
import 'package:online/custom_widget/custom_textfield.dart';
import 'package:online/model/cart_details_model.dart';
import 'package:online/screans/Cart_page/cart_page.dart';
import 'package:online/screans/home/cart_details.dart';
import 'package:online/utilsh/color.dart';
import 'package:online/utilsh/const.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: AppColor.blackColor,
            )), 
            title:  CustomTextField(
                onChanged: (value) {
                  setState(() {});
                },
                autoFocas: true,
                prefixIcon: Icons.search_outlined,
                controller: searchController,
                hintText: 'Search your favorite products'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.productFinalList.length,
                  itemBuilder: (context, index) {
                    final data = state.productFinalList[index];
                    if (searchController.text.isEmpty) {
                      return AddToCart2(
                          onTap: () {},
                          leading: data.model.image!,
                          onTab: () {
                            CartDetailsModel model = CartDetailsModel(
                                id: data.model.id!,
                                stock: data.model.rating!.count!,
                                imagePath: data.model.image!,
                                name: data.model.title!,
                                price: data.model.toString(),
                                rating: data.model.rating!.rate.toString(),
                                discriprion: data.model.description!,
                                cetagory: data.model.category!);
                            AppName.push(
                                context: context,
                                object: CardDetails(item: model));
                          },
                          title: data.model.title!,
                          subTitle: data.model.price.toString());
                    } else {
                      if (state.productFinalList[index].model.title!
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return AddToCart2(
                            onTap: () {},
                            leading: data.model.image!,
                            onTab: () {
                              CartDetailsModel model = CartDetailsModel(
                                  id: data.model.id!,
                                  stock: data.model.rating!.count!,
                                  imagePath: data.model.image!,
                                  name: data.model.title!,
                                  price: data.model.toString(),
                                  rating:
                                      data.model.rating!.rate.toString(),
                                  discriprion: data.model.description!,
                                  cetagory: data.model.category!);
                              AppName.push(
                                  context: context,
                                  object: CardDetails(item: model));
                            },
                            title: data.model.title!,
                            subTitle: data.model.price.toString());
                      } else {
                        return Container();
                      }
                    }
                  });
            },
          ),
        ),
      ),
    );
  }
}
