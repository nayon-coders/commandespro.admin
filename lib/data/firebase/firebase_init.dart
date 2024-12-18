import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseInit {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const String category_oriantation = "category_orientation";
}