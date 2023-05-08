import 'package:flutter/material.dart';
import '../custom_widget/ProfilImage.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/commentaires.dart';
import '../mes classes/membres.dart';

class DetailTile extends StatelessWidget{

  Commentaires commentaires;

  DetailTile({required this.commentaires});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GestionnaireFirbase().fireStoreInstance.collection("membres").doc(commentaires.idMembre).snapshots(),
        builder: (ctx,snapshot){
          if(snapshot.hasData){
            final user = Membres.fromJson(snapshot.data!);
            return ListTile(
              leading: ProfileImage(url: user.urlimage!, onPressed: () {}),
              title: Text(""),
              subtitle: Text(
                "${commentaires.text}\n commenté par ${user.nom} ${user.prenom}\n\n  date : ${commentaires.date} ",
                style: TextStyle(color:Colors.black),
              ),
            );
          }else{
            return Container();
          }
        }
    );
  }

}