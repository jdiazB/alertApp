import 'package:flutter/material.dart';
import 'package:untitled6_clase11/services/api_service.dart';
import 'package:untitled6_clase11/ui/general/colors.dart';
import 'package:untitled6_clase11/ui/pages/home_page.dart';
import 'package:untitled6_clase11/ui/widgets/buttom_custom_widget.dart';
import 'package:untitled6_clase11/ui/widgets/general_widget.dart';
import 'package:untitled6_clase11/ui/widgets/texfield_custom_widget.dart';
import 'package:untitled6_clase11/utils/assets_data.dart';
import 'package:untitled6_clase11/utils/constants.dart';

import '../../models/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _dnicontroller = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

// funcion post enviar datos
  Future _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ApiService apiService = ApiService();
      String _dni = _dnicontroller.text;
      String _password = _passwordController.text;
      UserModel? userModel = await apiService.login(_dni, _password);
      isLoading = true;
      setState(() {});
      if (userModel != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 120),
          behavior:  SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)
            ),
            backgroundColor: Colors.redAccent,
            content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            spacingWidth12,
            Text("Hubo un error, intentalo nuevamente"),
          ],
        )));
        setState(() {});
      }
      //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            spacing30,
                            Image.asset(
                              AssetData.logo,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Alerta App",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.05,
                                  color: kFontPrimaryColor),
                            )
                          ],
                        ),
                        spacing30,
                        Text(
                          "gggggggggggggggggggggg",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: kFontPrimaryColor.withOpacity(0.60)),
                        ),
                        spacing40,
                        TextFieldCustomWidget(
                            controller: _dnicontroller,
                            hintext: "Tu numero de DNI",
                            label: "Ingresa tu DNI",
                            inputTypeEnum: InputTypeEnum.dni),
                        spacing10,
                        TextFieldCustomPasswordWidget(
                            controller: _passwordController,
                            hintext: "Tu numero de DNI",
                            label: "Ingresa tu DNI"),
                        spacing30,
                        ButtomCustomWidget(onTap: (){
                          _login(context);
                        },text:"Iniciar sesion" ,),
                        spacing30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Aun no estas registrado? ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: kFontPrimaryColor.withOpacity(0.75)),
                            ),
                            Text(
                              "Registrate",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: kFontPrimaryColor.withOpacity(0.75)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2.3),
              ),
            ),
    );
  }
}
