import 'package:flutter/material.dart';

class CustomTextTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  void Function() onTap;

   CustomTextTileWidget({
     required this.title,
     required this.icon,
     required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      splashColor: Colors.transparent,
      leading: Icon(icon,size: 35,color: Colors.black,),
      title: Text(title,style: TextStyle(fontSize: 25),),
    );
  }
}
