import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';  // For kIsWeb
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class ImagePickerController extends GetxController {
  var pickedImage = Rx<File?>(null);  // For mobile and desktop
  var webImage = Rx<Uint8List?>(null); // For web

  // Method to pick an image from the gallery
  Future<void> pickSingleImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        // For web, use FileReader to get the image as Uint8List
        final bytes = await pickedFile.readAsBytes();
        webImage.value = bytes;
      } else {
        // For mobile and desktop, use File
        pickedImage.value = File(pickedFile.path);
      }
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Method to clear selected image
  void clearImage() {
    pickedImage.value = null;
    webImage.value = null;
  }
}
