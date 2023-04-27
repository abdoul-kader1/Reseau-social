import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/gestionnaireFirebase.dart';
import '../mes classes/Post.dart';
import '../mes classes/membres.dart';
import '../tile/PostTile.dart';
class Menu extends StatefulWidget{

  Membres membres;

  Menu({super.key,required this.membres});

  @override
  MenuState createState() =>MenuState();
}

class MenuState extends State<Menu>{

  late StreamSubscription streamSubscription;
  List<Membres>listMembre=[];
  List<Post>listPost=[];

  @override
  void initState() {
    configuration();
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context,scrolled){
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    image:DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                        image: NetworkImage("https://images.pexels.com/photos/4057766/pexels-photo-4057766.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
                    ),
                  ),
                ),
                title: Text("Fil d'actualité"),
              ),
              backgroundColor: Colors.purpleAccent,
            )
          ];
        },
        body: ListView.builder(
          itemCount: listPost.length+1,
            itemBuilder: (contexte,index){
            print(listPost.length);
              if(index==listPost.length){
                return const SizedBox(height: 100);
              }else{
                final post = listPost[index];
                final user = listMembre.singleWhere((element) => element.uid==post.membreId);
                return PosTile(post: post, membre:user);
              }
            }
        )
    );
  }

  listenToPost(Post post){
    post.ref!.snapshots().listen((event) {
      Post unPost = listPost.singleWhere((element) => element.documentId == post.documentId);
      listPost.remove(unPost);
      listPost.add(post);
      listPost.sort((a,b)=>b.date!.compareTo(a.date as num));
      setState(() {

      });
    });
  }
  configuration(){
    streamSubscription = GestionnaireFirbase().fireStoreInstance.collection("membres").where("followersKey",arrayContains: widget.membres.uid).snapshots().listen((event) {
      getMember(event.docs);
      event.docs.forEach((doc) {
        doc.reference.collection("Post").snapshots().listen((event) {
          setState(() {
            listPost = getPost(event.docs);
          });
        });
      });
    });
  }

  getPost(List<QueryDocumentSnapshot>lesPosts){
    List<Post>lesPost=listPost;
    lesPosts.forEach((element) {
      Post post = Post(element);
      listenToPost(post);
      if(lesPost.every((element) => element.documentId!=post.documentId)){
        lesPost.add(post);
      }else{
        Post toBeUptade = lesPost.singleWhere((element) => element.documentId==post.documentId);
        lesPost.remove(toBeUptade);
        lesPost.add(toBeUptade);
      }
    });
    listPost.sort((a,b)=>b.date!.compareTo(a.date as num));
    return lesPost;
  }

  getMember(List<QueryDocumentSnapshot>lesUsers){
    List<Membres>lesMembre=listMembre;
    lesUsers.forEach((element) {
      Membres users = Membres.fromJson(element);
      if(lesMembre.every((element) => element.uid!=users.uid)){
        lesMembre.add(users);
      }else{
        Membres toBeUptade = lesMembre.singleWhere((element) => element.uid==users.uid);
        lesMembre.remove(toBeUptade);
        lesMembre.add(toBeUptade);
      }
    });
    setState(() {
      listMembre = lesMembre;
    });
  }
}