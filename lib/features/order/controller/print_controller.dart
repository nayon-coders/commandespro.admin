import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class PrintController extends GetxController {
  // Access the query parameters from the URL
  final Uri uri = Uri.base;

  final GlobalKey printKey = GlobalKey();

  void printScreen() async{
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      const body = '''
    <h1>Heading Example</h1>
    <p>This is a paragraph.</p>
    <img src="image.jpg" alt="Example Image" />
    <blockquote>This is a quote.</blockquote>
    <ul>
      <li>First item</li>
      <li>Second item</li>
      <li>Third item</li>
    </ul>
    ''';

      final pdf = pw.Document();
      final widgets = await HTMLToPdf().convert(body);
      pdf.addPage(pw.MultiPage(build: (context) => widgets));
      return await pdf.save();
    });
  }
}