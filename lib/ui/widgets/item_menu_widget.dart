import 'package:flutter/material.dart';

import '../general/colors.dart';
import 'general_widget.dart';

class ItemMenuWidget extends StatelessWidget {
  String text;
  Color color;
  IconData icon;
  Function onTap;
  ItemMenuWidget({
    required this.text,
    required this.color,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  offset: Offset(0, 4),
                  blurRadius: 12.0
              ),
            ]
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.7),
                    shape: BoxShape.circle
                ),
                child: Icon(icon,color: Colors.white,)),
            spacing6,
            Text(text, style: TextStyle(
                color: kFontPrimaryColor.withOpacity(0.85), fontSize: 15
            ),),
          ],
        ),

      ),
    );
  }
}
