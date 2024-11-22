
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  AppInput({super.key,
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
    required this.text

  });
  final String hint;
  final String text;
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



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$text",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(

          onTap: onClick,
          onChanged: onChanged,
          maxLines: maxLine,
          keyboardType:textType,
          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: Color(
              0xFF262626)),
          readOnly:readOnly ,
          obscureText:obscureText ,
          controller:controller ,
          validator: (v){
            if(isValidatorNeed){
              if(v!.isEmpty){
                return "This field is required.";
              }
              return null;
            }

          },
          decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.all(20),
            hintText: hint,
            hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.blueGrey),

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
        ),
      ],
    );
  }
}
