import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/bloc/My_Account/my_account_bloc.dart';
import 'package:online/bloc/My_Account/my_account_event.dart';
import 'package:online/bloc/My_Account/my_account_state.dart';
import 'package:online/custom_widget/custom_appbar.dart';
import 'package:online/custom_widget/custom_buttons.dart';
import 'package:online/utilsh/color.dart';

class PickImage extends StatelessWidget {
  const PickImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  context
                      .read<MyAccountBloc>()
                      .add(PickImageEvent(conext: context));
                },
                child: BlocBuilder<MyAccountBloc, MyAccountState>(
                  builder: (contet, state) {
                    return Material(
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        // height: size.height * 0.20,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 2, color: AppColor.backgroundColor),
                        ),
                        child: state.imagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(
                                    state.imagePath!.path,
                                  ),
                                  fit: BoxFit.contain,
                                ))
                            : Center(
                                child: Icon(
                                  Icons.image,
                                  size: 30,
                                  color:
                                      AppColor.backgroundColor.withOpacity(.4),
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              BlocBuilder<MyAccountBloc, MyAccountState>(
                builder: (contet, state) {
                  return CustomButton(
                      loading: state.isSave,
                      buttonName: 'Save Image',
                      onTap: () {
                        context
                            .read<MyAccountBloc>()
                            .add(SaveImageEvent(context: context));
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
