import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddressModel extends ChangeNotifier {
  String _id = '';
  String _address = '';

  AddressModel();

  AddressModel.generateId() {
    var db = FirebaseFirestore.instance;
    CollectionReference adresses = db.collection("my-addresses");
    id = adresses.doc().id;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  AddressModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    address = doc['address'] ?? '';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "address": address,
    };

    return map;
  }
}
