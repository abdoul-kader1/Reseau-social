import 'package:flutter/material.dart';
import '../mes classes/membres.dart';

class Groupes extends StatelessWidget{

  Membres membres;

  Groupes({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Bienvenu sur votre Groupes"));
  }

}