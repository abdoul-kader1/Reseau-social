import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/custom_widget/ProfilImage.dart';
import 'package:reseausocial/mes%20classes/Post.dart';
import '../Modele/alerteHelper.dart';
import '../custom_widget/DateHandler.dart';
import '../custom_widget/Post_Content.dart';
import '../custom_widget/paddingwidth.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';

class PosTile extends StatelessWidget{

  Post post;
  Membres membre;

  PosTile({super.key,required this.post,required this.membre});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 5,
        child: PaddingWidth(
          child: Column(
            children: [
              Post_Content(post: post, membre: membre),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                        GestionnaireFirbase().addOrRemoveLike(post,GestionnaireFirbase().authInstance.currentUser!.uid);
                      },
                      icon: Icon((post.likes!.contains(membre.uid))?Icons.favorite:Icons.favorite_border,color: (post.likes!.contains(membre.uid))?Colors.red:Colors.black,)
                  ),
                  Text("${post.likes!.length} likes"),
                  IconButton(
                      onPressed: (){AlerteHelper().ecrireUnCommentaire(context, post: post, commentaire: TextEditingController(), membre: membre);},
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

