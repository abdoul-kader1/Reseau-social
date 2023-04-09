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

  Membres(DocumentSnapshot snapshot){
    print("snapshot d'un membre $snapshot");
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