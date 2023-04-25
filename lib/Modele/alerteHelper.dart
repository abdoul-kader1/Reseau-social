import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/custom_widget/mytextfield.dart';

import '../firebase/gestionnaireFirebase.dart';
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
                    GestionnaireFirbase().ModifierDonnerUser(membres,name.text, surName.text,description.text);
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