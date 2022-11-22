import 'package:flutter/material.dart';

import 'package:untitled6_clase11/models/news_model.dart';
import 'package:untitled6_clase11/services/api_service.dart';
import 'package:untitled6_clase11/ui/general/colors.dart';
import 'package:untitled6_clase11/ui/pages/news_register_page.dart';

import '../widgets/general_widget.dart';

class NewsPage extends StatelessWidget {
  ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    // _apiService.getNews();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsRegisterPage(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: kBrandPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            spacing10,
            Text(
              "Listado de Noticias",
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            spacing10,
            FutureBuilder(
                future: _apiService.getNewslist(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    List<NewsModel> listnews = snap.data;
                    print(snap.data);
                    return Expanded(
                      child: ListView.separated(
                          itemCount: listnews.length,
                          separatorBuilder: (context, index) => Divider(
                                indent: 12,
                                endIndent: 12.0,
                              ),
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(
                                  "${listnews[index].id}-Noticia : ${listnews[index].titulo}",
                                  style: TextStyle(
                                      color: kFontPrimaryColor.withOpacity(0.8),
                                      fontSize: 15.0),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        "link: ${listnews[index].link}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: kFontPrimaryColor
                                                .withOpacity(0.55),
                                            fontSize: 13),
                                      ),
                                    ),
                                    spacing3,
                                    Text(
                                      "Fecha: ${listnews[index].fecha.toString().substring(0, 10)}",
                                      style: TextStyle(
                                          color: kFontPrimaryColor
                                              .withOpacity(0.55),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  width: 100,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              listnews[index].link),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(4, 4),
                                          blurRadius: 10,
                                        )
                                      ]),
                                ));
                          }),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            // FutureBuilder(
            //
            //     future: _apiService.getNews() ,
            //     builder: (BuildContext context, AsyncSnapshot snap) {
            //       if (snap.hasData) {
            //          List<ListNewsModel> listnews = snap.data;
            //         print(snap.data);
            //         return Expanded(
            //           child: ListView.separated(
            //
            //               itemCount: listnews.length,
            //               separatorBuilder: (context, index) => Divider(
            //                 indent: 12,
            //                 endIndent: 12.0,
            //               ),
            //               itemBuilder: (context, index) {
            //                 return ListTile(
            //                   title: Text( "${listnews[index].id}-Noticia : ${listnews[index].titulo}",
            //                     style: TextStyle(
            //                         color: kFontPrimaryColor.withOpacity(0.8),
            //                         fontSize: 15.0),
            //                   ),
            //                   subtitle: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       GestureDetector(
            //                         child: Text(
            //                           "link: ${listnews[index].link}",
            //                           overflow: TextOverflow.ellipsis,
            //                           maxLines: 1,
            //                           style: TextStyle(
            //                               color:
            //                               kFontPrimaryColor.withOpacity(0.55),
            //                               fontSize: 13),
            //                         ),
            //                       ),
            //                       spacing3,
            //                       Text(
            //                         "Fecha: ${listnews[index].fecha.toString().substring(0,10)}",
            //                         style: TextStyle(
            //                             color:
            //                             kFontPrimaryColor.withOpacity(0.55),
            //                             fontSize: 13),
            //                       ),
            //
            //                     ],
            //                   ),
            //                   trailing: Container(
            //                     width: 100,height: 200,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(14),
            //                       image: DecorationImage(image: NetworkImage(listnews[index].link),fit: BoxFit.cover),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.black,
            //                           offset: Offset(4, 4),
            //                           blurRadius: 10,
            //
            //                         )
            //                       ]
            //                     ),
            //
            //                   )
            //                 );
            //               }),
            //         );
            //       }return Center(child: CircularProgressIndicator());
            //     }
            // ),
          ],
        ),
      ),
    );
  }
}
