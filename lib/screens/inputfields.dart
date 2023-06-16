import 'dart:convert';
import 'package:firebase_signin/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_signin/reusable_widgets/reusable_widget.dart';
import 'package:firebase_signin/utils/color_utils.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../Utils/app_colors.dart';
import '../Utils/dimensions.dart';
import '../utils/btn.dart';

class InputFieldsScreen extends StatelessWidget {
  final _ageController = TextEditingController();
  final _sexController = TextEditingController();
  final _chestPainController = TextEditingController();
  final _bpController = TextEditingController();
  final _cholesterolController = TextEditingController();
  final _fbsController = TextEditingController();
  final _ekgController = TextEditingController();
  final _maxHrController = TextEditingController();
  final _exerciseAnginaController = TextEditingController();
  final _stDepressionController = TextEditingController();
  final _slopeOfStController = TextEditingController();
  final _numOfVesselsController = TextEditingController();
  final _thalliumController = TextEditingController();
  String result = '';

  get allowDecimal => true;

  void _predict(BuildContext context) async {
    final url =
        'http://10.0.2.2:5000/predict'; // Replace with your Flask app URL

    try {
      final data = {
        'Age': double.parse(_ageController.text),
        'sex': double.parse(_sexController.text),
        'chestpain': double.parse(_chestPainController.text),
        'bp': double.parse(_bpController.text),
        'cholestrol': double.parse(_cholesterolController.text),
        'fbs': double.parse(_fbsController.text),
        'ekg': double.parse(_ekgController.text),
        'hr': double.parse(_maxHrController.text),
        'exercise': double.parse(_exerciseAnginaController.text),
        'depression': double.parse(_stDepressionController.text),
        'slope': double.parse(_slopeOfStController.text),
        'vessels': double.parse(_numOfVesselsController.text),
        'thallium': double.parse(_thalliumController.text),
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      print(json.encode(data));
      print(result);
      if (response.statusCode == 200) {
        String prediction = json.decode(response.body)['result'].toString();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Prediction',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                ' $prediction',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid input'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle parsing errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("4cb4d5"),
              hexStringToColor("52afff"),
              hexStringToColor("3282d4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: logoWidget("assets/images/logo2.png"),
                  ),
                  Text(
                    'CardiAlert',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 20, 0),
                  child: Column(
                    children: <Widget>[
                      reusableTextField(
                        "Age (in years)",
                        Icons.date_range_outlined,
                        false,
                        _ageController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Sex",
                        Icons.person_outline,
                        false,
                        _sexController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Chest pain type",
                        Icons.monitor_heart,
                        false,
                        _chestPainController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "BP",
                        Icons.monitor_heart,
                        false,
                        _bpController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Cholesterol",
                        Icons.monitor_heart,
                        false,
                        _cholesterolController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "FBS over 120",
                        Icons.monitor_heart,
                        false,
                        _fbsController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "EKG results",
                        Icons.monitor_heart,
                        false,
                        _ekgController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Max HR",
                        Icons.monitor_heart,
                        false,
                        _maxHrController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Exercise angina",
                        Icons.monitor_heart,
                        false,
                        _exerciseAnginaController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "ST depression",
                        Icons.monitor_heart,
                        false,
                        _stDepressionController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Slope of ST",
                        Icons.monitor_heart,
                        false,
                        _slopeOfStController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Number of vessels fluro",
                        Icons.monitor_heart,
                        false,
                        _numOfVesselsController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        "Thallium",
                        Icons.monitor_heart,
                        false,
                        _thalliumController,
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 5),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "Predict",
                        textColor: AppColors.white,
                        color: Colors.blue,
                        fontSize: 15,
                        onPressed: () {
                          if(_cholesterolController.text.isEmpty){
                            Fluttertoast.showToast(
                                msg: 'Invalid Input',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColors.mainColor,
                                textColor: Colors.white,
                                fontSize: 20.0);
                          }
                          else if (double.parse(_cholesterolController.text) < 150) {
                            Fluttertoast.showToast(
                                msg: 'Low Risk',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColors.mainColor,
                                textColor: Colors.white,
                                fontSize: 20.0);
                          } else if (double.parse(_cholesterolController.text) >
                              150) {
                            Fluttertoast.showToast(
                                msg: 'High Risk',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColors.mainColor,
                                textColor: Colors.white,
                                fontSize: 20.0);
                          }
                          _predict(context);
                        },
                      ),
                      // ElevatedButton(
                      //   onPressed:() => _predict(context),
                      //   child: Text("Predict"),
                      //
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reusableTextField(
    String label,
    IconData icon,
    bool obscureText,
    TextEditingController controller,
  ) {
    return TextFormField(
      style: TextStyle(color: Colors.white), // set the text color to white here
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      obscureText: obscureText,
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
        TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(text: newValue.text),
        ),
      ],
    );
  }

  String _getRegexString() =>
      allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}
