import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';

class Profil extends StatefulWidget{

  @override
  ProfilState createState() =>ProfilState();

  Membres membres;

  Profil({super.key,required this.membres});

}

class ProfilState extends State<Profil>{

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController()..addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: GestionnaireFirbase().requetePost(widget.membres.uid!),
        builder: (contexte,snapshot){
          if(snapshot.hasData){
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                listSliver(snapshot.data!.docs)
              ],
            );
          }else{
            return Center(child: Text("Aucun post pour le moment"));
          }
        });
  }
  listSliver(List<DocumentSnapshot> document){
    return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount:document.length,
            (context,index){
                return ListTile(
                  title: Text("donnne numeros ${index}"),
                );
              }
        )
    );
  }
}