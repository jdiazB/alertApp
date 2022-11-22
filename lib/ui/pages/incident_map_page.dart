import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled6_clase11/ui/general/colors.dart';

import '../../models/incident_model.dart';

class IncidentMapPage extends StatefulWidget {
  List<IncidentModel> incidentList;
  IncidentMapPage({
    required this.incidentList
  });


  @override
  State<IncidentMapPage> createState() => _IncidentMapPageState();
}

class _IncidentMapPageState extends State<IncidentMapPage> {
  Set<Marker> _markers = {};

 @override
 initState(){
 super.initState();
 buildMarkers();
 }

  buildMarkers(){
    for(var item in widget.incidentList){
      Marker marker = Marker(
        markerId: MarkerId(_markers.length.toString()),
        position: LatLng(item.latitud, item.longitud),
        onTap: () {
          print(item.tipoIncidente.title);
        },
      );
      _markers.add(marker);
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          GoogleMap(
            initialCameraPosition:  CameraPosition(
              target: LatLng(-11.261080, -76.331244),
              zoom: 6.5,
            ),
            markers: _markers,
            // onTap: (LatLng position){
            //   Marker myMarker = Marker(markerId: MarkerId(_markers.length.toString()),
            //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            //   position: position);
            //
            //   _markers.add(myMarker);
            //   setState(() {
            //
            //   });
            // },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.incidentList.map((e) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  margin: EdgeInsets.symmetric(horizontal: 6,vertical: 12.0),
                  decoration: BoxDecoration(

                      color:kBrandSecundaryColor,
                      borderRadius: BorderRadius.circular(14.0)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(e.tipoIncidente.title),
                      Text("Ciudadano : ${e.datosCiudadano.nombres}",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 20,color: Colors.indigo
                      ),),
                      Text("Telefono: ${e.datosCiudadano.telefono}"),
                      Text("Hora : ${e.hora}"),
                      Text("Fecha: ${e.fecha}")

                    ],
                  ),
                )).toList()
              ),
            ),
          )

        ],
      )
    );
  }
}
