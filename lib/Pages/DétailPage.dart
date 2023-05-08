import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/mes%20classes/membres.dart';
import '../Controlleur/DetailTile.dart';
import '../custom_widget/Post_Content.dart';
import '../mes classes/Post.dart';
import '../mes classes/commentaires.dart';

class DetailPage extends StatefulWidget{

  Post post;
  Membres membres;

  DetailPage({required this.membres,required this.post});

  @override
  DetailPageState createState() =>DetailPageState();

}

class DetailPageState extends State<DetailPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Détail post")),
      body: StreamBuilder<DocumentSnapshot>(
          stream: widget.post.ref!.snapshots(),
          builder: (contexte,snapshot){
            if(snapshot.hasData){
              List<Commentaires>commentaires = [];
              final Map<dynamic,dynamic>donnee = snapshot.data!.data() as Map;
              final List<dynamic> lesCommentaires = donnee["commentaires"];
              lesCommentaires.forEach((element) {
                commentaires.add(Commentaires(map: element));
              });
              return ListView.separated(
                  itemBuilder: (contexte,index){
                    if(index==0){
                      return Post_Content(post: widget.post, membre: widget.membres);
                    }else{
                      final donnee = commentaires[index-1];
                      return DetailTile(commentaires: donnee);
                    }
                  },
                  separatorBuilder: (contexte,index)=>Divider(),
                  itemCount: commentaires.length+1
              );
            }else{
              return Text("Pas de donnée");
            }
          }
      ),
    );
  }
}
