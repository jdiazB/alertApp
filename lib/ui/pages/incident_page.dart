import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled6_clase11/models/incident_type_model.dart';
import 'package:untitled6_clase11/ui/pages/incident_map_page.dart';
import 'package:untitled6_clase11/ui/pages/modals/register_incident_modal.dart';

import '../../models/incident_model.dart';
import '../../services/api_service.dart';
import '../general/colors.dart';
import '../widgets/general_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class IncidentPage extends StatefulWidget {
  @override
  State<IncidentPage> createState() => _IncidentPageState();
}

class _IncidentPageState extends State<IncidentPage>
    with TickerProviderStateMixin {
  ApiService apiService = ApiService();
  List<IncidentTypeModel> incidentTypeList = [];
  List<IncidentModel>  listData=[];

  @override
  initState() {
    super.initState();
    getData();
  }

  // aqui estamos llamando la informacion de la pagina de lista de incidencias para que se visualice en show ya que esta almacenda en la instancia
  getData() async {
    incidentTypeList = await apiService.getIncidentType();
  }

  showAddIncidentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      transitionAnimationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 650)),
      builder: (BuildContext context) {
        return RegisterIncidentModal(
          incidentTypeList: incidentTypeList,
        );
      },
    ).then((value) {
      setState(() {

      });
    });
  }

  buildPDF() async{

    ByteData byteData = await rootBundle.load('assets/images/hoja.png');
    Uint8List imageBytes = byteData.buffer.asUint8List();
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context){
        return [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children:
              [
                pw.Image(
                pw.MemoryImage(imageBytes), height: 50.0
          ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Bienvenido"),
                  ]
                )
              ]
          ),
          pw.Divider(),
          pw.ListView.builder(
              itemCount: listData.length,
              itemBuilder: (pw.Context context, int index){
                return pw.Container(
                  margin: pw.EdgeInsets.symmetric(vertical: 16.0),
                  padding: pw.EdgeInsets.symmetric(horizontal: 10.0,vertical: 12.0),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 0.7,
                      color: PdfColors.black
                    ),
                  ),
                  child: pw.Row(
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Tipo Incidente: "),
                            pw.Text("Ciudadano: "),
                            pw.Text("Teléfono: "),
                            pw.Text("Documento Identidad: "),
                            pw.Text("Fecha: "),
                            pw.Text("Hora: "),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(listData[index].tipoIncidente.title),
                            pw.Text(listData[index].datosCiudadano.nombres),
                            pw.Text(listData[index].datosCiudadano.telefono),
                            pw.Text(listData[index].datosCiudadano.dni),
                            pw.Text(listData[index].fecha),
                            pw.Text(listData[index].hora),
                          ],
                        ),
                      ]
                  ),
                );
              }
          ),
        ];
      })
    );
    Uint8List bytes= await pdf.save();
    Directory directory = await getApplicationDocumentsDirectory();
    File filepdf= File("${directory.path}/alerta.pdf");
    filepdf.writeAsBytes(bytes);
    OpenFilex.open(filepdf.path);
    print(directory.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              buildPDF();

            },
            child: Container(

              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,


              ),
              child: Icon(Icons.picture_as_pdf, color: Colors.white,),
            ),
          ),
          spacing10,
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => IncidentMapPage(
                incidentList: listData,
              ),));

            },
            child: Container(

              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kFontPrimaryColor,
                  shape: BoxShape.circle,


              ),
              child: Icon(Icons.map, color: Colors.white,),
            ),
          ),
          spacing10,

          FloatingActionButton(
            onPressed: () {
              showAddIncidentModal(context);
            },
            backgroundColor: kBrandPrimaryColor,
            child: Icon(Icons.add),
          ),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de Incidentes",
                style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.80),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacing20,
              FutureBuilder(
                future: apiService.getIncident(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                     listData = snap.data;
                    return Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: listData.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              listData[index].tipoIncidente.title,
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.80),
                                  fontSize: 15.0),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                spacing3,
                                Text(
                                  "Ciudadano: ${listData[index].datosCiudadano.nombres}",
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                                spacing3,
                                Text(
                                  "Teléfono: ${listData[index].datosCiudadano.telefono}",
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listData[index].hora,
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                                spacing3,
                                Text(
                                  listData[index].fecha,
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
