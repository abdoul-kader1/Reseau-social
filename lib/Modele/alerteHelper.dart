import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/gestionnaireFirebase.dart';

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
}