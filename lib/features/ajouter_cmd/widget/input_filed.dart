
import 'package:flutter/material.dart';

class InputFiled extends StatelessWidget {
  InputFiled({super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.validator,
    this.textType,
    this.onClick,
    this.onChanged,
    this.maxLine = 1,
    this.isValidatorNeed = true,
    this.obscure = false,
    this.isExpanded = false,

  });
  final String hint;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  String? Function(String?)? validator;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? textType;
  final VoidCallback? onClick;
  final Function(String)? onChanged;
  final int maxLine;
  final bool isValidatorNeed;
  final bool obscure;
  final bool isExpanded;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: isExpanded,
      cursorHeight: 15,
      onTap: onClick,
      onChanged: onChanged,
      maxLines: maxLine,
      keyboardType:textType,
      style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: Color(
          0xFF262626)),
      readOnly:readOnly ,
      obscureText:obscureText ,
      controller:controller ,
      validator: (v){
        if(isValidatorNeed){
          if(v!.isEmpty){
            return "This filed must not be empty.";
          }
          return null;
        }

      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 5,right: 5,top: 10),
        hintText: hint,
        hintStyle:const TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.blueGrey),

        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: Colors.white,
        filled: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
