import 'package:flutter/material.dart';
import 'package:untitled6_clase11/ui/general/colors.dart';
import 'package:untitled6_clase11/ui/pages/citizen_page.dart';
import 'package:untitled6_clase11/ui/pages/incident_type_page.dart';
import 'package:untitled6_clase11/ui/pages/news_page.dart';
import 'package:untitled6_clase11/ui/widgets/general_widget.dart';

import '../widgets/item_menu_widget.dart';
import 'incident_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenido Ramon",
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            spacing10,
            Text(
              "Lorem ipsum.............................................................",
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.65),
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
            spacing14,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 14,
                children: [
                  ItemMenuWidget(
                      text: "Ciudadanos",
                      color: Color(0xfff72585),
                      icon: Icons.people,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CitizenPage(),
                            ));
                      }),
                  ItemMenuWidget(
                    text: "Incidentes",
                    color: Color(0xffffba08),
                    icon: Icons.add_alert,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IncidentPage()));
                    },
                  ),
                  ItemMenuWidget(
                    text: "Noticias",
                    color: Color(0xff00509d),
                    icon: Icons.newspaper,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage(),));
                    },
                  ),
                  ItemMenuWidget(
                    text: "Reportes",
                    color: Color(0xff02c39a),
                    icon: Icons.bar_chart,
                    onTap: () {},
                  ),
                  // ItemMenuWidget(
                  //   text: "Otros",
                  //   color: Color(0xff7b2cbf),
                  //   icon: Icons.bar_chart,
                  //   onTap: () {},
                  // ),
                  ItemMenuWidget(
                    color: Color(0xff7b2cbf),
                    icon: Icons.warning,
                    text: "Tipos Incidentes",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IncidentTypePage()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
