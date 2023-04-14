import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  DocumentReference? ref;
  String? documentId;
  String? id;
  String? membreId;
  String? text;
  String? imageUrl;
  int? date;
  List<dynamic>?likes;
  List<dynamic>?commentaire;

  Post(DocumentSnapshot snapshot){
    ref = snapshot.reference;
    documentId = snapshot.id;
    final donnee = snapshot.data() as Map;
    membreId = donnee["id"];
    id = donnee["idPost"];
    text = donnee["texte"];
    imageUrl = donnee["urlImage"];
    date = donnee["date du post"];
    likes = donnee["likes"];
    commentaire = donnee["commentaires"];
  }
  Map<String,dynamic>toMap(){
   return {
     "idPost": id??documentId,
     "id":membreId,
     "likes":likes,
     "commentaires":commentaire,
     "texte":text,
     "urlImage":imageUrl
    };
  }

}