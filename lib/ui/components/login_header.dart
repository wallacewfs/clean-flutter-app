import 'package:flutter/material.dart';

class loginHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin:EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end : Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark
            ]
           ),
           boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 0,
              blurRadius: 0,
              color: Colors.black
            )
           ],
           borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80))
         ),
      child: const Image(image: AssetImage('lib/ui/assets/logo.png')),
    );
  }
}