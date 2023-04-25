import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:reseausocial/mes%20classes/membres.dart';
import '../mes classes/Post.dart';

class GestionnaireFirbase{
  //database
  FirebaseAuth authInstance=FirebaseAuth.instance;
  FirebaseFirestore fireStoreInstance= FirebaseFirestore.instance;
  //storage
  final storageRef = storage.FirebaseStorage.instance.ref();
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
        "description":"",
        "followingKey":[]
      };
    }
    EnvoieDonnee(Member());
    return users!;
  }
  
  EnvoieDonnee( Map<String,dynamic>maps)async{
    await fireStoreInstance.collection("membres").doc(maps["uidKey"]).set(maps);
  }
  addImageStorage(storage.Reference ref,File file)async{
    storage.UploadTask task = ref.putFile(file);
    storage.TaskSnapshot snapshot = await task.whenComplete(() => null);
    String urlPhotoPost = await snapshot.ref.getDownloadURL();
    return urlPhotoPost;
  }

  addToPost(String idMembre,String texte,File file)async{
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic>commentaire = [];
    List<dynamic>likes = [];
    Map<String,dynamic>donnee = {
      "id":idMembre,
      "texte":texte,
      "date du post":date,
      "commentaires":commentaire,
      "likes":likes,
    };
    final ref = storageRef.child(idMembre).child("Post").child(date.toString());
    donnee["urlImage"] = await addImageStorage(ref,file);
    fireStoreInstance.collection("membres").doc(idMembre).collection("Post").doc().set(donnee);
  }

  Stream<QuerySnapshot> requetePost(String idUser){
    return FirebaseFirestore.instance.collection("membres").doc(idUser).collection("Post").snapshots();
  }

  addOrRemoveLike(Post post,String idMembre){
    if(post.likes!.contains(idMembre)){
      post.ref!.update({"likes":FieldValue.arrayRemove([idMembre])});
    }else{
      post.ref!.update({"likes":FieldValue.arrayUnion([idMembre])});
    }
  }
  
  modifierPhotoProfile(File file)async{
    final uidMembre = authInstance.currentUser!.uid;
    final cheminFirebaseStorage = storageRef.child(uidMembre).child("Photo de profil");
    final fonction = await addImageStorage(cheminFirebaseStorage,file);
    fireStoreInstance.collection("membres").doc(uidMembre).update({"urlimageKey":fonction});
  }

  deconnecterUser(){
    authInstance.signOut();
  }

  ModifierDonnerUser(Membres membres,String nom,String preNom,String description)async{
    if( (nom!="" && nom!=null) || (preNom!="" && preNom!=null) || (description!="" && description!=null) ){
      membres.ref!.update({"nomKey":nom,"prenomKey":preNom,"description":description});
    }else{
      return "impossible d'enregistrer les données Certain champ n'ont pas été remplir";
    }
  }


}