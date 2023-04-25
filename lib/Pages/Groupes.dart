import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';

class Groupes extends StatelessWidget{

  Membres membres;

  Groupes({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: GestionnaireFirbase().fireStoreInstance.collection("membres").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return NestedScrollView(
                headerSliverBuilder: (ctx,valeur){
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      backgroundColor: Colors.purpleAccent,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text("Listes des utilisateurs"),
                        background: Image.network("https://images.pexels.com/photos/2777898/pexels-photo-2777898.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      ),
                    )
                  ];
                },
                body: Center(child: Text("${snapshot.data!.docs.length}"))
            );
          }else{
            return Center(child: Text("Aucun membre dans cette application"));
          }
        }
    );
  }
}