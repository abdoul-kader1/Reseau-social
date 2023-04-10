import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/mes%20classes/membres.dart';

class Acceuil extends StatefulWidget{

  Acceuil({super.key});

  @override
  State<StatefulWidget> createState()=>_Acceuil();
}

class _Acceuil extends State<Acceuil>{

  String idUtilisateur = FirebaseAuth.instance.currentUser!.uid;
  late Membres membres;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("membres").doc(idUtilisateur).snapshots(),
        builder: (contexte, snapchot){
        if(snapchot.hasData){
          membres = Membres.fromJson(snapchot.data as DocumentSnapshot<Object?>);
          return Scaffold(
            appBar: AppBar(
              title: Text("acceuil"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bonjour ${membres.nom} ${membres.prenom}"),
                  Text("Votre identifiant est: ${membres.uid}"),
                  Text("Votre email est: ${FirebaseAuth.instance.currentUser!.email}"),
                  ElevatedButton(
                      onPressed: (){FirebaseAuth.instance.signOut();},
                      child:Text("Se connecter")
                  )
                ],
              ),
            ),
          );
        }else{
          return Container(color: Colors.white);
        }
        }
    );
}
}
