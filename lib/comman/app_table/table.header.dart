
import 'package:flutter/material.dart';


class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key, required this.name, required this.width,
  });
  final String name;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("$name",
          textAlign: TextAlign.start,
          style:const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}



class AppTableRow extends StatelessWidget {
  const AppTableRow({
    super.key, required this.name, required this.width,
  });
  final String name;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("$name",
          textAlign: TextAlign.start,
          style:const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}