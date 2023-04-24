import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/custom_widget/ProfilImage.dart';
import 'package:reseausocial/mes%20classes/Post.dart';
import '../custom_widget/DateHandler.dart';
import '../custom_widget/paddingwidth.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';

class PosTile extends StatelessWidget{
  QueryDocumentSnapshot snapshots;
  Membres membre;
  PosTile({super.key,required this.snapshots,required this.membre});

  @override
  Widget build(BuildContext context) {
    Post post = Post(snapshots);
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 5,
        child: PaddingWidth(
          child: Column(
            children: [
              Row(
                children: [
                  ProfileImage(url: membre.urlimage!, onPressed:(){}),
                  SizedBox(width: 20),
                  Column(
                    children: [Text("${membre.prenom} ${membre.nom}"),Text("${DateHandler().myDate(post.date!)}")],
                  ),
                ],
              ),
              PaddingWidth(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.width*0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image:DecorationImage(
                          image: CachedNetworkImageProvider(post.imageUrl!),
                        fit: BoxFit.cover
                      )
                    ),
                  )
              ),
              Text('${post.text}'),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                        GestionnaireFirbase().addOrRemoveLike(post,membre.uid!);
                      },
                      icon: Icon((post.likes!.contains(membre.uid))?Icons.favorite:Icons.favorite_border)
                  ),
                  Text("${post.likes!.length} likes"),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.message)
                  ),
                  Text("${post.commentaire!.length} Commentaires"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}