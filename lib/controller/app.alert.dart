

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future confirmAlert({required BuildContext context,  required String body, required VoidCallback onOk})async{
  return await confirm(
    context,
    title: const Text('Confirm'),
    content:  Text('$body'),
    textOK: TextButton(
        onPressed: onOk,
        child: Text("YES")
    ),
    textCancel:  TextButton(
        onPressed: ()=>Get.back(),
        child: Text("NO")
    ),
  );
}