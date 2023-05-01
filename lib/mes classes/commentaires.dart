import '../custom_widget/DateHandler.dart';

class Commentaires{

  String?idMembre;
  String?text;
  String?date;

  Commentaires({required Map<String,dynamic>map}){
    idMembre = map["uidKey"];
    text = map["texte"];
    date = DateHandler().myDate(map["date du post"]);
  }

}