import 'package:flutter/material.dart';
import '../mes classes/membres.dart';
class Menu extends StatelessWidget{

  Membres membres;

  Menu({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("bonjour ${membres.nom} ${membres.prenom}"),
        Text("Votre identifiant est : ${membres.uid}"),
      ],
    );
  }
}