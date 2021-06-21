import 'package:flutter/material.dart';

class OnboardButton extends StatelessWidget {
  final Color color;
  final String title;
  final Icon icon;
  final Function onPressed;

  OnboardButton({this.title, this.color, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child:  SizedBox(
          width: 160.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                padding: new EdgeInsets.all(5.0),
                icon: icon,
                tooltip: title,
                onPressed: onPressed,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}