import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/custom_widget/DateHandler.dart';
import 'package:reseausocial/custom_widget/ProfilImage.dart';
import 'package:reseausocial/custom_widget/paddingwidth.dart';
import '../mes classes/Post.dart';
import '../mes classes/membres.dart';

class Post_Content extends StatelessWidget{

  Post post;
  Membres membre;

  Post_Content({super.key,required this.post,required this.membre});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}