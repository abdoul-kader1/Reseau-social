import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reseausocial/custom_widget/DateHandler.dart';

class InsideNotification{

  DocumentReference?reference;
  String?texte;
  String?date;
  String?userId;
  DocumentReference?aboutRef;
  bool?seen;
  String?type;

  InsideNotification(DocumentSnapshot snapshot){
    reference = snapshot.reference;
    Map<dynamic, dynamic>data = snapshot.data() as Map;
    texte = data["texte"];
    date = DateHandler().myDate(data["date"]);
    userId = data["userId"];
    seen = data["seen"];
    type = data["type"];
    aboutRef = data["aboutRef"];
  }
}