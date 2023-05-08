import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/mes%20classes/Post.dart';
import '../Modele/InsideNotification.dart';
import '../custom_widget/LienPage.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';
import 'DétailPage.dart';
import 'Profil.dart';

class InfoUser extends StatelessWidget{

  InsideNotification infoNotification;
  String idUser;

  InfoUser({required this.infoNotification,required this.idUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:  GestionnaireFirbase().fireStoreInstance.collection("membres").doc(infoNotification.userId).snapshots(),
        builder: (ctx, snapshot){
          if(snapshot.hasData){
            final user = Membres.fromJson(snapshot.data!);
            return ListTile(
              onTap: (){
                GestionnaireFirbase().luNonLu(infoNotification);
                verificationTypeNotif(context,user);
              },
              leading: Icon(Icons.email),
              title: Text("${user.prenom} ${infoNotification.texte}"),
              subtitle: Text("a ${infoNotification.date}"),
              trailing: (infoNotification.seen==false)?CircleAvatar(radius: 5,backgroundColor: Colors.red):Text("Lu"),
            );
          }else{
            return Container();
          }
        }
    );
  }
  //verifie type de notification
  verificationTypeNotif(BuildContext context,Membres user){
    if(infoNotification.type=="Follow"){
        Navigator.push(context,LienPage(page:Profil(membres: user)));
    }else if(infoNotification.type=="like" || infoNotification.type=="Commentaire"){
      infoNotification.aboutRef!.snapshots().listen((event) {
        Post post = Post(event);
          Navigator.push(context,LienPage(
              page: DetailPage(membres: user, post: post))
          );
        });
    }
  }
}