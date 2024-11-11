
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';


class FirebaseImageController{
  static List<int>? _selectedFile;
  static Uint8List? _bytesData;

  static startWebFilePicker(Function updateCallback) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      print("this is files === $files");
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        _bytesData = Base64Decoder().convert(reader.result.toString().split(",").last);
        _selectedFile = _bytesData;
        updateCallback(_bytesData);
      });
      reader.readAsDataUrl(file);
    });

  }


  //conver image for firebase
  static Future<String> uploadImageToFirebaseStorage(Uint8List imageFile, String pathName) async {
    try {
      print('Error uploading image to Firebase Storage: ');
      var storageReference = FirebaseStorage.instance.ref().child('$pathName/${DateTime.now().millisecondsSinceEpoch}');
      var uploadTask = storageReference.putData(imageFile);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      print("downloadUrl file == ${downloadUrl}");
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
}