import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled6_clase11/models/incident_register_model.dart';
import 'package:untitled6_clase11/services/api_service.dart';
import 'package:untitled6_clase11/ui/widgets/buttom_custom_widget.dart';

import '../../../models/incident_type_model.dart';
import '../../general/colors.dart';
import '../../widgets/general_widget.dart';

class RegisterIncidentModal extends StatefulWidget {
  List<IncidentTypeModel> incidentTypeList;

  RegisterIncidentModal({
    required this.incidentTypeList,
  });

  @override
  State<RegisterIncidentModal> createState() => _RegisterIncidentModalState();
}

class _RegisterIncidentModalState extends State<RegisterIncidentModal> {
  int incidentValue = 0;
  Position? position;
  // late o nulo cualquiera de los dos
  @override
  initState() {
    super.initState();
    incidentValue = widget.incidentTypeList.first.id;
    getDataPosition();
  }

  getDataPosition() async {
    position = await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28.0))),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Registrar Incidente",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kFontPrimaryColor.withOpacity(0.88)),
          ),
          spacing10,
          Text(
            "Por favor seleciona un incidente para ser enviado a la central",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kFontPrimaryColor.withOpacity(0.6)),
          ),
          spacing20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 0.9,
                  color: kFontPrimaryColor.withOpacity(0.12),
                )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                borderRadius: BorderRadius.circular(16.0),
                elevation: 6,
                value: incidentValue,
                isExpanded: true,
                items: widget.incidentTypeList
                    .map((e) => DropdownMenuItem(
                          child: Text(e.title),
                          value: e.id,
                        ))
                    .toList(),
                onChanged: (int? value) {
                  incidentValue = value!;
                  setState(() {});
                },
              ),
            ),
          ),
          spacing30,
          ButtomCustomWidget(
              text: "Registrar Incidente",
              onTap: () async {
                ApiService apiService = ApiService();
                IncidentRegisterModel model = IncidentRegisterModel(
                  latitude: position!.latitude,
                  longitude: position!.longitude,
                  incidentTypeId: incidentValue,
                  status: "Abierto",
                );
                bool res = await apiService.registerIncident(model);
                if(res){
                  Navigator.pop(context);
                }
              })
        ],
      ),
    );
  }
}
