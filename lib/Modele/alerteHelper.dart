import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}