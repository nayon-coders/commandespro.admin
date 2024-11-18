import 'package:commandespro_admin/utility/text_style.dart';
import 'package:flutter/material.dart';

class VtaListTile extends StatelessWidget {
  const VtaListTile({super.key, required this.title, required this.amount});
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Align(
          alignment: Alignment.centerRight,
            child: Text(title,style: pTextStyle(),)),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white
          ),
          child: Align(
            alignment: Alignment.centerLeft,
              child: Text("${amount}",style:  TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.blueGrey),)),
        )
      ],
    );
  }
}
