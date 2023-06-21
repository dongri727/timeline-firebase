/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selected {
  Selected(
      this.name,
      this.year,
      this.country,
      );
  String name;
  double year;
  String country;
}

class SearchFirestore extends ChangeNotifier {
  List<Selected>? selected;

  void searchEvent() async {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('events')
        .where("country", isEqualTo: 'Japan')
        .get();

    List<DocumentSnapshot> docSnapshots = querySnapshot.docs;

    for (DocumentSnapshot docSnapshot in docSnapshots) {
      Map<String, dynamic> map = docSnapshot.data() as Map<String, dynamic>;


      return Selected(
      name, year, country,
      );
    }).toList();

    this.selected = search;
    notifyListeners();
  }

  final clearController = TextEditingController();
}
*/
