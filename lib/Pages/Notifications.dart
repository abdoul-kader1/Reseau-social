import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/Modele/InsideNotification.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';
import 'InfoUser.dart';

class Notifications extends StatelessWidget{

  Membres membres;

  Notifications({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: GestionnaireFirbase().fireStoreInstance.collection("Notification").doc(membres.uid).collection("inside").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx,index){
                final recupDonnee = snapshot.data!.docs;
                InsideNotification notification = InsideNotification(recupDonnee[index]);
                  return InfoUser(infoNotification: notification,idUser: membres.uid!);
                }
            );
          }else{
            return Container();
          }
        }
    );
  }

}