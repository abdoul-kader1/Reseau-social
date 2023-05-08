import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseausocial/custom_widget/ProfilImage.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';
import 'Profil.dart';

class Groupes extends StatelessWidget{

  Membres membres;

  Groupes({super.key,required this.membres});

  @override
  Widget build(BuildContext context) {
    final myId = GestionnaireFirbase().authInstance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: GestionnaireFirbase().fireStoreInstance.collection("membres").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return NestedScrollView(
                headerSliverBuilder: (ctx,valeur){
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      backgroundColor: Colors.purpleAccent,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text("Listes des utilisateurs"),
                        background: Container(
                          decoration: BoxDecoration(
                            image:DecorationImage(
                              fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                                image: NetworkImage("https://images.pexels.com/photos/1438072/pexels-photo-1438072.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
                            ),
                          ),
                        )
                      ),
                    )
                  ];
                },
                body: ListView.separated(
                    itemBuilder: (ctx,index){
                      final listDonnee = snapshot.data!.docs;
                      final donnee = listDonnee[index];
                      final user = Membres.fromJson(donnee);
                      return ListTile(
                        leading: ProfileImage(url: user.urlimage!, onPressed: () {}),
                        title: Text("${user.nom}"),
                        subtitle: Text("${user.prenom}"),
                        trailing: TextButton(
                          onPressed: () {
                            GestionnaireFirbase().followUser(user,myId,membres);
                          },
                          child: (myId == user.uid)
                              ?Container(height: 0,width: 0)
                              :Text((user.followers!.contains(myId)?"Ne plus suivre":"Suivre"))
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx){
                                    return Scaffold(body:Profil(membres: user));
                                  }
                              )
                          );
                        },
                      );
                    },
                    separatorBuilder: ((ctx,index)=>Divider(color: Colors.purple,indent: 60,height: 20,)),
                    itemCount: snapshot.data!.docs.length
                )
            );
          }else{
            return Center(child: Text("Aucun membre dans cette application"));
          }
        }
    );
  }
}