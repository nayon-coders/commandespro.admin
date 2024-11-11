import 'package:commandespro_admin/utility/app_const.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDown2<T> extends StatelessWidget {
  const DropDown2({super.key, required this.items, this.value, required this.hint, required this.onChange, this.selectedItemBuilder});
  final List<T> items;
  final T? value;
  final String hint;
  final ValueChanged<T?>onChange;
  final DropdownButtonBuilder? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(

      style: TextStyle(color: AppColors.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      isExpanded: true,
      decoration:  InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:const EdgeInsets.symmetric(vertical: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        border:  OutlineInputBorder(

          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),

        // Add more decoration..
      ),
      hint:  Text(hint,
        style:const TextStyle(color: AppColors.darkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
      items: items.map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(
          item.toString(),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textColor,
          ),
        ),
      )).toList(),
      value: value,
      onChanged: onChange,
      selectedItemBuilder: selectedItemBuilder,

      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: AppColors.textLightColor,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          border:Border.all(color: AppColors.darkGrey,),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

