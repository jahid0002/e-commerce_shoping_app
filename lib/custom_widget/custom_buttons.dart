import 'package:flutter/material.dart';
import 'package:online/utilsh/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonName,
      required this.onTap,
      this.loading = false});
  final bool loading;
  final String buttonName;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
      clipBehavior: Clip.hardEdge,
      color: AppColor.backgroundColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: loading ? null : onTap,
        child: Container(
          alignment: Alignment.center,
          height: size.height * 0.09,
          width: size.width,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColor.whiteColor,
                ))
              : Text(
                  buttonName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColor.whiteColor),
                ),
        ),
      ),
    );
  }
}

class CustomDoubleButton extends StatelessWidget {
  const CustomDoubleButton({
    super.key,
    this.firstLoading = false,
    this.secondloading = false,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.firstOnTap,
    required this.secondOnTap,
  });
  final bool firstLoading;
  final bool secondloading;
  final String firstButtonName;
  final String secondButtonName;
  final VoidCallback firstOnTap;
  final VoidCallback secondOnTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: AppColor.whiteColor,
            clipBehavior: Clip.hardEdge,
            shape: ContinuousRectangleBorder( borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(100)),
                side: BorderSide(
                  style: BorderStyle.solid,
                  color: AppColor.backgroundColor, width: 2)),
            child: InkWell(
              onTap: firstLoading ? null : firstOnTap,
              child: Container(
                alignment: Alignment.center,
                height: size.height * 0.09,
                width: size.width / 2.5,
                // decoration: BoxDecoration(border: Border.all(color: AppColor.backgroundColor,width: 2)),
                child: firstLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColor.whiteColor,
                      ))
                    : Text(
                        firstButtonName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColor.backgroundColor),
                      ),
              ),
            ),
          ),
          SizedBox(width: size.height * 0.02,),
          Material(
            clipBehavior: Clip.hardEdge,
            color: AppColor.backgroundColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(50)),
            child: InkWell(
              onTap: secondloading ? null : secondOnTap,
              child: Container(
                alignment: Alignment.center,
                height: size.height * 0.09,
                width: size.width / 2.5,
                child: secondloading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColor.whiteColor,
                      ))
                    : Text(
                        secondButtonName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColor.whiteColor),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
