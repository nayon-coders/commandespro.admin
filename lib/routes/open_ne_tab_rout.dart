// import 'dart:html' as html;
//
// void openNewTab(String route) {
//   final url = "${Uri.base.origin}#" + route; // Uri.base.origin gives the base URL of your app
//   html.window.open(url, '_blank');
// }

import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../features/order/screen/export_prepar_view.dart';
import '../features/order/screen/print_invoice.dart';

void openNewTab(String route, {Map<String, String>? arguments}) {
  // Construct the base URL with the provided route
  var url = "${Uri.base.origin}#$route";

  // If there are arguments, add them as query parameters
  if (arguments != null && arguments.isNotEmpty) {
    final uri = Uri.parse(url).replace(queryParameters: arguments);
    url = uri.toString();
  }

  // Open the new tab with the URL and arguments
  html.window.open(url, '_blank');
}



void openPreparationNewTab(BuildContext context, Map<String, dynamic> data,) {
  if (kIsWeb) {
    // Encode the data as part of the URL
    final encodedData = Uri.encodeComponent(jsonEncode(data));
    final url = 'assets/prepar-invoice/index.html?data=$encodedData'; // Point to your web page
    html.window.open(url, '_blank'); // Open in a new tab
  } else {
    // Use regular navigation for non-web platforms
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExportPreparWebVIew(jsonData: data),
      ),
    );
  }
}


void openNewTabInvoice(BuildContext context, Map<String, dynamic> data,) {
  if (kIsWeb) {
    // Encode the data as part of the URL
    final encodedData = Uri.encodeComponent(jsonEncode(data));
    final url = 'assets/invoice-print/index.html?data=$encodedData'; // Point to your web page
    html.window.open(url, '_blank'); // Open in a new tab
  } else {
    // Use regular navigation for non-web platforms
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrintInvoiceView(jsonData: data),
      ),
    );
  }
}
