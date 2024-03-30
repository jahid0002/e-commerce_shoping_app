import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/Add_To_Cart/add_cart_bloc.dart';
import 'package:online/bloc/Add_To_Cart/add_cart_event.dart';
import 'package:online/bloc/Add_To_Cart/add_cart_state.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_buttons.dart';
import 'package:online/utilsh/color.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    context.read<AddCartBloc>().add(const GetTotalPrice());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
          context: context, leaading: Container(), title: 'Cart'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: PersistentShoppingCart().showCartItems(
          cartTileWidget: ({required PersistentShoppingCartItem data}) { 
            
            return Column(
              children: [
                AddToCart(
                  leading: data.productImages![0],
                  onTap: () {
                    _showDeleteDialog(context, data.productId);
                  },
                  title: data.productName,
                  subTitle: data.unitPrice.toString(),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Size: ${data.productId}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: size.height * 0.042,
                          width: size.height * 0.07,
                          decoration: BoxDecoration( 
                            borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: AppColor.backgroundColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<AddCartBloc>().add(AddQuantityEvent(id: data.productId, quantity:data.quantity));
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 22,
                                ),
                              ),
                              Text(
                                data.quantity.toString(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              InkWell(
                                  onTap: () {context.read<AddCartBloc>().add(RemoveQuantityEvent(id: data.productId, quantity:data.quantity));},
                                  child: const Icon(
                                    Icons.remove,
                                    size: 22,
                                  ))
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            );
          },
          showEmptyCartMsgWidget: const Center(child: Text('Empty Cart')),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: size.height * 0.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  BlocBuilder<AddCartBloc, AddCartState>(
                    builder: (context, state) {
                      return Text(
                        '\$ ${state.totalPrice}',
                        style: Theme.of(context).textTheme.displayLarge,
                      );
                    },
                  ),
                ],
              ),
              CustomButton(buttonName: 'Buy Now', onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
  
  void _showDeleteDialog(BuildContext context, String productId)async {
      return showDialog(context: context, builder: (_){return AlertDialog(
        title: Text('Are you sure delete this item?', style: Theme.of(context).textTheme.displayLarge,), 
        actions: [
          Material( 
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(10), 
            color: AppColor.backgroundColor,
            child: InkWell(
              onTap: (){
             Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cancel", style: Theme.of(context).textTheme.labelLarge,),
              ),
            ),
          ), Material( 
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(10), 
            color: AppColor.backgroundColor,
            child: InkWell(
              onTap: ()async{
              await PersistentShoppingCart().removeFromCart(productId).then((value){
                  context.read<AddCartBloc>().add(const GetTotalPrice());
                 Navigator.pop(context);});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Delete", style: Theme.of(context).textTheme.labelLarge,),
              ),
            ),
          )
        ],
      );});
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart(
      {super.key,
      required this.leading,
      required this.onTap,
      required this.title,
      this.trailing,
      required this.subTitle, 
      this.onTab
      });
  final String title;
  final String leading;
  final VoidCallback onTap;
  final Widget? trailing;
  final String subTitle; 
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(15),
          color: AppColor.backgroundColor.withOpacity(0.1),
          child: InkWell(
            onTap: onTab,
            onLongPress: onTap,
            child: SizedBox(
              height: size.height * 0.12,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: leading,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: size.height * 0.01,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              child: Text(title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          overflow: TextOverflow.ellipsis)),
                            ),
                            SizedBox(
                              height: size.height * 0.001,
                            ),
                            Text('\$ $subTitle',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                    trailing ??
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColor.blackColor,
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        )
      ],
    );
  }
} 

class AddToCart2 extends StatelessWidget {
  const AddToCart2(
      {super.key,
      required this.leading,
      required this.onTap,
      required this.title,
      this.trailing,
      required this.subTitle, 
      this.onTab
      });
  final String title;
  final String leading;
  final VoidCallback onTap;
  final Widget? trailing;
  final String subTitle; 
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(15),
          color: AppColor.backgroundColor.withOpacity(0.1),
          child: InkWell(
            onTap: onTab,
            onLongPress: onTap,
            child: SizedBox(
              height: size.height * 0.12,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: size.height * 0.10, 
                          width: size.height * 0.10,
                          child: CachedNetworkImage(
                            imageUrl: leading,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: size.height * 0.01,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              child: Text(title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          overflow: TextOverflow.ellipsis)),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text('\$ $subTitle',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                    trailing ??
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColor.blackColor,
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        )
      ],
    );
  }
}



