import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Delegate/HeaderDelegate.dart';
import '../Modele/alerteHelper.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/membres.dart';
import '../tile/PostTile.dart';

class Profil extends StatefulWidget{

  @override
  ProfilState createState() => ProfilState();

  Membres membres;

  Profil({super.key,required this.membres});

}

class ProfilState extends State<Profil>{

  late ScrollController scrollController;
  bool get scrolled => scrollController.hasClients && scrollController.offset > 200 - kToolbarHeight;
  late bool isMe;
  final authUser = GestionnaireFirbase().authInstance.currentUser!.uid;
  late TextEditingController leNom;
  late TextEditingController leSurnom;
  late TextEditingController laDescription;

  @override
  void initState() {
    leNom = TextEditingController();
    leSurnom = TextEditingController();
    laDescription = TextEditingController();
    isMe = (authUser == widget.membres.uid);
    scrollController = ScrollController()..addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    leNom.dispose();
    leSurnom.dispose();
    laDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: GestionnaireFirbase().requetePost(widget.membres.uid!),
        builder: (contexte,snapshot){
          if(snapshot.hasData){
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                sliverAppBar(),
                persistent(),
                listSliver(snapshot.data!.docs)
              ],
            );
          }else{
            return Center(child: Text("Aucun post pour le moment"));
          }
        });
  }
  takePicture(){
    if(isMe){
      return showModalBottomSheet(
          context: context,
          builder: (ctx){
            return Container(
              color: Colors.transparent,
              child: Card(
                elevation: 7,
                margin: EdgeInsets.all(7),
                child: Container(
                  color: Colors.cyanAccent,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Modification de la photo de profile"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                              onPressed: (()=>picker(ImageSource.gallery)),
                              icon: Icon(Icons.photo_library_outlined)
                          ),
                          IconButton(
                              onPressed: (()=>picker(ImageSource.camera)),
                              icon: Icon(Icons.camera_alt)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      );
    }
  }
  picker(ImageSource laSourceImage)async{
    final fichier = await ImagePicker().pickImage(source: laSourceImage,maxHeight: 500,maxWidth: 500);
    if(fichier!=null){
      final imageFichier = File(fichier.path);
      GestionnaireFirbase().modifierPhotoProfile(imageFichier);
    }
  }
  SliverPersistentHeader persistent(){
    return SliverPersistentHeader(
      pinned: true,
        delegate: HeaderDelegate(membre: widget.membres, onPressed: takePicture, scrolled: scrolled)
    );
  }
  sliverAppBar(){
    return SliverAppBar(
      backgroundColor: Colors.purple,
      pinned: true,
      expandedHeight: 200,
      actions: [
        IconButton(onPressed:(){AlerteHelper().deconnecter(context);}, icon: Icon(Icons.settings)),
        (isMe)?IconButton(onPressed:(){AlerteHelper().changeProprieteUser(context, membres: widget.membres, name: leNom, surName: leSurnom, description: laDescription);}, icon: Icon(Icons.mode_outlined)):Container(),
      ],
      flexibleSpace: FlexibleSpaceBar(
          title: (scrolled)?Text("${widget.membres.prenom} ${widget.membres.nom}",style: TextStyle(fontSize: 17),):Container(height: 0,width: 0),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://images.pexels.com/photos/3861964/pexels-photo-3861964.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
            )
          ),
        ),
      ),
    );
  }
  listSliver(List<QueryDocumentSnapshot> document){
    return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount:document.length+1,
            (context,index){
            if(index==document.length){
              return SizedBox(height: 100);
            }else{
              return PosTile(snapshots: document[index], membre: widget.membres);
            }
          }
        )
    );
  }
}