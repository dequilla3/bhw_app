import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class AppProvider extends ChangeNotifier {
  final Localstore db = Localstore.instance;

  createNewRequest(String details, bool isEmergency, String status) async {
    // gets new id
    final docId = db.collection('requests').doc().id;

// save the item
    await db.collection('requests').doc(docId).set({
      'id': docId,
      'details': details,
      'isEmergency': isEmergency,
      'status': status
    });
  }
}
