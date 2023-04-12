import 'package:flutter/material.dart';
import '../mes classes/membres.dart';

class Profil extends StatelessWidget{

  Membres membres;

  Profil({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
  return Center(child: Text("Bienvenu sur votre profil"));
  }

}