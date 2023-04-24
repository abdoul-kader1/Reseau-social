import 'package:cloud_firestore/cloud_firestore.dart';

class Membres{

  String?uid;
  String?nom;
  String?prenom;
  String?email;
  String?mdp;
  String?description;
  String?urlimage;
  List<dynamic>?followers;
  List<dynamic>?following;
  DocumentReference?ref;
  String?documentid;

  Membres.fromJson(DocumentSnapshot snapshot){
    final donnee = snapshot.data() as Map;
    uid = donnee["uidKey"];
    nom = donnee["nomKey"];
    prenom = donnee["prenomKey"];
    followers = donnee["followersKey"];
    following = donnee["followingKey"];
    urlimage = donnee["urlimageKey"];
    ref = snapshot.reference;
    documentid = snapshot.id;
  }

  Map<String,dynamic>Tomap(){
    return{
      "uidKey":uid,
      "nomKey":nom,
      "prenomKey":prenom,
      "emailKey":email,
      "mdpKey":mdp,
      "descriptionKey":description,
      'urlimageKey':urlimage,
      "followersKey":followers,
      "followingKey":following
    };
  }

}