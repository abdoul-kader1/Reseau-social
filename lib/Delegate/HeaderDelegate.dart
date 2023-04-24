import 'package:flutter/material.dart';
import '../custom_widget/ProfilImage.dart';
import '../mes classes/membres.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate{

  Membres membre;
  VoidCallback onPressed ;
  bool scrolled;

  HeaderDelegate({required this.membre,required this.onPressed,required this.scrolled});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      color: Colors.purpleAccent.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          (scrolled)
          ?Container(height: 0,width: 0)
          :InkWell(
            child: Text("${membre.prenom} ${membre.nom}"),
            onTap: onPressed,
          ),
          Text(membre.description??"Aucune description"),
          ProfileImage(url:membre.urlimage!, onPressed: onPressed,imageSize: 30),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Followers : ${membre.followers!.length}"),
              Text("Following : ${membre.following!.length}")
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => (scrolled)?150:190;

  @override
  // TODO: implement minExtent
  double get minExtent => (scrolled)?150:190;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate)=>(scrolled!=oldDelegate.scrolled || membre!=oldDelegate.membre);
  
}