import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GestionnaireFirbase{
  FirebaseAuth authInstance=FirebaseAuth.instance;
  FirebaseFirestore fireStoreInstance= FirebaseFirestore.instance;
  //connexion
  Future<User>Connextion({required String email,required String mdp})async{
    User? users=(await authInstance.signInWithEmailAndPassword(email: email, password:mdp)).user;
    return users!;
  }
  //inscription
  Future<User>Enregistrer({required String email,required String mdp,required String nom,required String prenom})async{
    User?users=(await authInstance.createUserWithEmailAndPassword(email: email, password:mdp)).user;

    Map<String,dynamic>Member(){
      return{
        "uidKey":users?.uid,
        "nomKey":nom,
        "prenomKey":prenom,
        'urlimageKey':"",
        "followersKey":[users?.uid],
        "followingKey":[]
      };
    }
    EnvoieDonnee(Member());
    return users!;
  }
  
  EnvoieDonnee( Map<String,dynamic>maps)async{
    await fireStoreInstance.collection("membres").doc(maps["uidKey"]).set(maps);
  }
  

}