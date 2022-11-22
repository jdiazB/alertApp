import 'package:flutter/material.dart';
import 'package:untitled6_clase11/models/citizen_model.dart';
import 'package:untitled6_clase11/services/api_service.dart';
import 'package:untitled6_clase11/ui/widgets/general_widget.dart';

import '../general/colors.dart';

class CitizenPage extends StatelessWidget {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Listado de ciudadanos",
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            spacing10,
            FutureBuilder(
                future: apiService.getCitizen(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    List<CitizenModel> listData = snap.data;
                    return Expanded(
                      child: ListView.separated(
                          itemCount: listData.length,
                          separatorBuilder: (context, index) => Divider(
                                indent: 12,
                                endIndent: 12.0,
                              ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                listData[index].fullName,
                                style: TextStyle(
                                    color: kFontPrimaryColor.withOpacity(0.8),
                                    fontSize: 15.0),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dirección: ${listData[index].address}",
                                    style: TextStyle(
                                        color:
                                            kFontPrimaryColor.withOpacity(0.55),
                                        fontSize: 13),
                                  ),
                                  spacing3,
                                  Text(
                                    "Teléfono: ${listData[index].phone}",
                                    style: TextStyle(
                                        color:
                                            kFontPrimaryColor.withOpacity(0.55),
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }return CircularProgressIndicator();
                }
                ),
          ],
        ),
      )),
    );
  }
}
