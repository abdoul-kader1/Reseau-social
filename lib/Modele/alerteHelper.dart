import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/custom_widget/mytextfield.dart';

import '../custom_widget/Post_Content.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/Post.dart';
import '../mes classes/membres.dart';

class AlerteHelper{

  Future<void>Erreur({ required BuildContext contexte,String?erreur})async{
    final titre=Text("Erreur");
    final sousTitre=erreur;
    return showDialog(
        context: contexte,
        builder: (BuildContext cxt){
          return AlertDialog(
            title: titre,
            content: Text(sousTitre!),
            actions: [
              ElevatedButton(
                  onPressed:(){
                    Navigator.pop(cxt);
                  },
                  child:Text("Ok")
              )
            ],
          );
        }
    );
  }
  Future deconnecter(BuildContext context)async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (contexte){
          return AlertDialog(
            title: Text("Attention !!!"),
            content: Text("Cette action va vous déconnecter, continuer ?"),
            actions: [
              ElevatedButton(onPressed: (){GestionnaireFirbase().deconnecterUser();Navigator.pop(contexte);}, child:Text("Oui")),
              ElevatedButton(onPressed: (){Navigator.pop(contexte);}, child:Text("Non")),
            ],
          );
        }
    );
  }

  ecrireUnCommentaire(BuildContext context,{required Post post,required TextEditingController commentaire,required Membres membre})async{
    final champEntrer = Mytextfield(controller: commentaire,hint: "Ecrire un commentaire");
    final texte = Text("Nouveau commentaire");
    return showDialog(
       barrierDismissible: false,
        context: context,
        builder: (ctx){
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceAround,
            contentPadding: EdgeInsets.all(20),
            title: texte,
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Post_Content(post: post, membre: membre),champEntrer],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    if(commentaire.text!=null && commentaire.text!=""){
                      GestionnaireFirbase().ecrirePost(post,commentaire.text);
                      Navigator.pop(ctx);
                    }
                    },
                  child:Text("Envoyer")
              ),
              ElevatedButton(onPressed: (){Navigator.pop(ctx);}, child:Text("Annuler")),
            ],
          );
        }
    );
  }

  changeProprieteUser(BuildContext context ,{
    required Membres membres,
    required TextEditingController name,
    required TextEditingController surName,
    required TextEditingController description
  })async{
    final champEntre1 = Mytextfield(controller: name,hint: "${membres.nom}",icon: Icon(Icons.person));
    final champEntre2 = Mytextfield(controller: surName,hint: "${membres.prenom}",icon: Icon(Icons.person));
    final champEntre3 = Mytextfield(controller: description,hint: "${membres.description==""?"Aucune description":"${membres.description}"}",icon: Icon(Icons.person));
    final titre = Text("Modification des données");
    return showDialog(
        context: context,
        builder: (ctx){
          return AlertDialog(
            title: titre,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                champEntre1,
                champEntre2,
                champEntre3
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Map<String,dynamic>donnee={};
                    if(name!=""&& name!=null){
                      donnee["nomKey"]=name.text;
                    }else{
                      donnee["nomKey"]=membres.nom;
                    }
                    if(surName!=""&& surName!=null){
                      donnee["prenomKey"]=surName.text;
                    }else{
                      donnee["prenomKey"]=membres.prenom;
                    }
                    if(description!=""&& description!=null){
                      donnee["description"]=description.text;
                    }else{
                      donnee["description"]=membres.description;
                    }
                    GestionnaireFirbase().ModifierDonnerUser(membres,donnee);
                    Navigator.pop(ctx);
                    },
                  child:Text("Modifier")
              ),
              ElevatedButton(onPressed: (){Navigator.pop(ctx);}, child:Text("Annuler")),
            ],
            actionsAlignment: MainAxisAlignment.spaceEvenly,
          );
        }
    );
  }
}