import 'package:flutter/material.dart';
import '../Pages/Groupes.dart';
import '../Pages/Menu.dart';
import '../Pages/Notifications.dart';
import '../Pages/Posts.dart';
import '../Pages/Profil.dart';
import 'Page.dart';

class Data{
  lesPages(){
    return [
      Pages(titrePage: 'Acceuil',destination: Menu()),
      Pages(titrePage: 'Profil',destination: Profil()),
      Pages(titrePage: 'Notification',destination: Notifications()),
      Pages(titrePage: 'Post',destination: Posts()),
      Pages(titrePage: 'Groupes',destination: Groupes()),
    ];
  }
}