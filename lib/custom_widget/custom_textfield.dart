import 'package:flutter/material.dart';
import 'package:online/utilsh/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.icon,
      this.showPass, 
      this.prefixIcon, this.autoFocas, this.onChanged, this.keybord
      });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? showPass;
  final IconData? prefixIcon; 
  final bool? autoFocas; 
  final Function(String)? onChanged; 
  final TextInputType? keybord;
  @override
  Widget build(BuildContext context) {
    return TextFormField( 
      keyboardType: keybord,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 18),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 22, color: AppColor.backgroundColor,): null,
        filled: true,
        fillColor: AppColor.backgroundColor.withOpacity(.1),
        hintText: hintText,
        suffixIcon:
            icon != null ? InkWell(onTap: showPass, child: Icon(icon)) : null,
            errorStyle: Theme.of(context).textTheme.labelSmall, 
            helperStyle: Theme.of(context).textTheme.labelSmall, 
            labelStyle: Theme.of(context).textTheme.labelSmall, 
            prefixStyle: Theme.of(context).textTheme.labelSmall, 
            counterStyle: Theme.of(context).textTheme.labelSmall, 
            suffixStyle: Theme.of(context).textTheme.labelSmall,
            floatingLabelStyle: Theme.of(context).textTheme.labelSmall,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: AppColor.backgroundColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1, color: AppColor.backgroundColor.withOpacity(.1))),
      ),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  const CustomTextField2(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.icon,
      this.showPass, 
      this.prefixIcon, this.autoFocas, this.onChanged, this.keybord, required this.title
      });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? showPass;
  final IconData? prefixIcon; 
  final bool? autoFocas; 
  final Function(String)? onChanged; 
  final TextInputType? keybord; 
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start, 

      children: [ 
        Text(title, style: Theme.of(context).textTheme.displayLarge,), 
        const SizedBox(height: 4,),
        TextFormField( 
          keyboardType: keybord,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 18),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 22, color: AppColor.backgroundColor,): null,
            filled: true,
            fillColor: AppColor.backgroundColor.withOpacity(.1),
            hintText: hintText,
            suffixIcon:
                icon != null ? InkWell(onTap: showPass, child: Icon(icon)) : null,
                errorStyle: Theme.of(context).textTheme.labelSmall, 
                helperStyle: Theme.of(context).textTheme.labelSmall, 
                labelStyle: Theme.of(context).textTheme.labelSmall, 
                prefixStyle: Theme.of(context).textTheme.labelSmall, 
                counterStyle: Theme.of(context).textTheme.labelSmall, 
                suffixStyle: Theme.of(context).textTheme.labelSmall,
                floatingLabelStyle: Theme.of(context).textTheme.labelSmall,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: AppColor.backgroundColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1, color: AppColor.backgroundColor.withOpacity(.1))),
          ),
        ),
      ],
    );
  }
}
