import 'package:flutter/material.dart';

import '../mes classes/membres.dart';

class Notifications extends StatelessWidget{

  Membres membres;

  Notifications({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Bienvenu sur votre Notifications"));
  }

}