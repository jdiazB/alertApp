import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled6_clase11/models/news_model.dart';
import 'package:untitled6_clase11/services/api_service.dart';
import 'package:untitled6_clase11/ui/general/colors.dart';
import 'package:untitled6_clase11/ui/widgets/buttom_custom_widget.dart';
import 'package:untitled6_clase11/ui/widgets/general_widget.dart';
import 'package:untitled6_clase11/ui/widgets/texfield_custom_widget.dart';

class NewsRegisterPage extends StatefulWidget {
  @override
  State<NewsRegisterPage> createState() => _NewsRegisterPageState();
}

class _NewsRegisterPageState extends State<NewsRegisterPage> {
  TextEditingController _titlecontroller = TextEditingController();

  TextEditingController _linkcontroller = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _imageFile;

  getImageCamera() async {
    _imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (_imageFile != null) {
      setState(() {});
    }
  }

  getImageGallery() async {
    _imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_imageFile != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kFontPrimaryColor,
        ),
        title: Text(
          "Registrar Noticia",
          style: TextStyle(color: kFontPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFieldCustomWidget(
                controller: _titlecontroller,
                label: "Titulo",
                hintext: "Ingrese un titulo",
              ),
              spacing14,
              TextFieldCustomWidget(
                controller: _linkcontroller,
                label: "Link",
                hintext: "Ingrese un link",
              ),
              spacing14,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageCamera();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      icon: Icon(Icons.camera),
                      label: Text("Camara"),
                    ),
                  ),
                  spacingWidth12,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageGallery();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      icon: Icon(Icons.image),
                      label: Text("Galeria"),
                    ),
                  ),
                ],
              ),
              spacing20,
              _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image(
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          image: FileImage(File(_imageFile!.path))),
                    )
                  : SizedBox(),
              spacing14,
              ButtomCustomWidget(
                  text: "Registrar noticia",
                  onTap: () {
                    ApiService apiService = ApiService();
                    NewsModel model = NewsModel(
                      link: _linkcontroller.text,
                      titulo: _titlecontroller.text,
                      fecha: DateTime.now(),
                      imagen: _imageFile!.path,
                    );
                    apiService.registerNews(model);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
