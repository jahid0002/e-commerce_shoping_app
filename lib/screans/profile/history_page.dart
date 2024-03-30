import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/My_Account/my_account_bloc.dart';
import 'package:online/bloc/My_Account/my_account_event.dart';
import 'package:online/bloc/My_Account/my_account_state.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/screans/Cart_page/cart_page.dart';
import 'package:online/utilsh/color.dart';
import 'package:online/utilsh/const.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyAccountBloc>().add(const GetHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.customAppBar(context: context, title: 'History'),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<MyAccountBloc, MyAccountState>(
                  builder: (context, state) {
                    //    print(state.data!.docs.length);
                    switch (state.status) {
                      case Status.loading:
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColor.backgroundColor,
                        ));
                      case Status.fail:
                        return Center(
                            child: Text(
                          'Empty',
                          style: Theme.of(context).textTheme.displayLarge,
                        ));
                      case Status.success:
                        return ListView.builder( 
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            reverse: true,
                            itemCount: state.data!.docs.length,
                            itemBuilder: (context, index) {
                              return AddToCart2(
                                  leading: '${state.data!.docs[index]['image']}',
                                  onTap: () {},
                                  title: '${state.data!.docs[index]['name']}',
                                  subTitle:
                                      '${state.data!.docs[index]['price']}');
                            });
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
