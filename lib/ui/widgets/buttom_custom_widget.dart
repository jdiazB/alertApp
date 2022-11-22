import 'package:flutter/material.dart';

import '../general/colors.dart';

class ButtomCustomWidget extends StatelessWidget {

  String text;
  Function onTap;
  ButtomCustomWidget({
    required this.text,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       onTap();
        // ApiService apiservice = ApiService();
        // apiservice.login();
      },
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  color:
                  kBrandPrimaryColor.withOpacity(0.4))
            ],
            gradient: LinearGradient(colors: [
              kBrandPrimaryColor,
              kBrandSecundaryColor
            ])),
        child: Text(
          text,
          style: TextStyle(
              color: kFontPrimaryColor.withOpacity(0.75),
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        ),
      ),
    );
  }
}
