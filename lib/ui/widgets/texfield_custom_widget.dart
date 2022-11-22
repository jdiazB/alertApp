import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class TextFieldCustomWidget extends StatelessWidget {
  String label;
  String hintext;
  TextEditingController controller;
  InputTypeEnum? inputTypeEnum;

  TextFieldCustomWidget(
      {required this.controller,
      required this.label,
      required this.hintext,
       this.inputTypeEnum});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: kFontPrimaryColor.withOpacity(0.60)),
        ),
        spacing10,
        TextFormField(
          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return "Campo obligatorio";
            }
            if (inputTypeEnum == InputTypeEnum.dni && value!.length < 8) {
              return "Ingrese 8 digitos";
            }

            return null;
          },
          keyboardType: inputTypeMap[inputTypeEnum],
          controller: controller,
          maxLength: inputTypeEnum == InputTypeEnum.dni ? 8 : null,
          inputFormatters: inputTypeEnum == InputTypeEnum.dni ||
                  inputTypeEnum == InputTypeEnum.telefono
              ? [FilteringTextInputFormatter.allow(RegExp("[0-9]"))]
              : [],
          style: TextStyle(
              color: kFontPrimaryColor.withOpacity(0.8), fontSize: 14.0),
          decoration: InputDecoration(
            counter: SizedBox(),
            hintText: hintext,
            hintStyle: TextStyle(
                fontSize: 14.0, color: kFontPrimaryColor.withOpacity(0.5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
          ),
        ),
      ],
    );
  }
}

class TextFieldCustomPasswordWidget extends StatefulWidget {
  String label;
  String hintext;
  TextEditingController controller;

  TextFieldCustomPasswordWidget(
      {required this.controller, required this.label, required this.hintext});

  @override
  State<TextFieldCustomPasswordWidget> createState() =>
      _TextFieldCustomPasswordWidgetState();
}

class _TextFieldCustomPasswordWidgetState
    extends State<TextFieldCustomPasswordWidget> {
  bool isInvisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tu contraseña",
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: kFontPrimaryColor.withOpacity(0.60)),
        ),
        spacing10,
        TextFormField(
          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return "Campo obligatorio";
            }
            return null;
          },
          controller: widget.controller,
          obscureText: isInvisible,
          style: TextStyle(
              color: kFontPrimaryColor.withOpacity(0.8), fontSize: 14.0),
          decoration: InputDecoration(
            hintText: "Ingrese su contraseña",
            suffixIcon: IconButton(
              onPressed: () {
                isInvisible = !isInvisible;
                setState(() {});
              },
              icon: Icon(
                Icons.remove_red_eye_outlined,
                size: 18,
                color: kFontPrimaryColor.withOpacity(0.5),
              ),
            ),
            hintStyle: TextStyle(
                fontSize: 14.0, color: kFontPrimaryColor.withOpacity(0.5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.12), width: 0.9)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.15), width: 0.9)),
          ),
        ),
      ],
    );
  }
}
