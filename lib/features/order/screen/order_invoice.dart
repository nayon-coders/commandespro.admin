
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:commandespro_admin/utility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import '../controller/print_controller.dart';
class OrderInvoice extends StatefulWidget {
  const OrderInvoice({super.key});

  @override
  State<OrderInvoice> createState() => _OrderInvoiceState();
}

class _OrderInvoiceState extends State<OrderInvoice> {
  // Access the query parameters from the URL
  final Uri uri = Uri.base;
  final GlobalKey containerKey = GlobalKey();


  final PrintController printController = Get.put(PrintController());

  @override
  Widget build(BuildContext context) {
    final String? id = uri.queryParameters['order_id'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  RepaintBoundary(
          key: containerKey, // Key to capture the widget
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/logo.png', height: 50),
                        SizedBox(height: 20),

                        Text("CommandesPro",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("10, rue de la Chicane\n59620 Villeneuve d'Ascq",
                          style: invoiceText(),
                        ),
                        Text("Tel.: 01 23 45 67 89",
                          style: invoiceText(),
                        ),
                        Text("Email: contact@commandespros.com",
                          style: invoiceText(),
                        )

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Invoice No.: ",
                                style: invoiceTextTitle()
                            ),
                            Text("FA202404-0440",
                                style: invoiceText()
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Invoice date: ",
                                style: invoiceTextTitle()
                            ),
                            Text("04/26/2024",
                                style: invoiceText()
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Order No.: ",
                                style: invoiceTextTitle()
                            ),
                            Text("2966",
                                style: invoiceText()
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Order date: ",
                                style: invoiceTextTitle()
                            ),
                            Text("04/26/2024",
                                style: invoiceText()
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Billing address:",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("10, rue de la Chicane\n59620 Villeneuve d'Ascq",
                          style: invoiceText(),
                        ),
                        Text("Tel.: 01 23 45 67 89",
                          style: invoiceText(),
                        ),
                        Text("Email: contact@commandespros.com",
                          style: invoiceText(),
                        )

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery address:",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("10, rue de la Chicane\n59620 Villeneuve d'Ascq",
                          style: invoiceText(),
                        ),
                        Text("Tel.: 01 23 45 67 89",
                          style: invoiceText(),
                        ),
                        Text("Email: contact@commandespros.com",
                          style: invoiceText(),
                        )

                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text("Print Container"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to print the container

}
