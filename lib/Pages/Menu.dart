import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../mes classes/membres.dart';
class Menu extends StatelessWidget{

   late Membres membres;
  String idUtilisateur = FirebaseAuth.instance.currentUser!.uid;

  Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("membres").doc(idUtilisateur).snapshots(),
        builder:(contexte,snapshot){
          if(snapshot.hasData){
            membres = Membres.fromJson(snapshot.data as DocumentSnapshot<Object?>);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("bonjour ${membres.nom} ${membres.prenom}"),
                Text("Votre identifiant est : ${membres.uid}"),
                ElevatedButton(
                    onPressed: (){FirebaseAuth.instance.signOut();},
                    child:Text("Se déconnecter")
                )
              ],
            );
          }else{
            return Container();
          }
        }
    );
  }

}