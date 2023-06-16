
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_signin/utils/color_utils.dart';

import '../Utils/app_colors.dart';

class UploadTestScreen extends StatefulWidget {
  @override
  _UploadTestScreenState createState() => _UploadTestScreenState();
}

class _UploadTestScreenState extends State<UploadTestScreen> {
  List<Map<String, dynamic>> uploadedData = [];

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      try {
        String csvData = await file.readAsString();
        List<List<dynamic>> csvTable = [];
        List<String> rows = csvData.split('\n'); // Split the string into rows
        List<dynamic> columnNames = ['Age', 'sex', 'chestpain', 'bp', 'cholestrol', 'fbs', 'ekg', 'hr', 'exercise', 'depression', 'slope', 'vessels', 'thallium'];
        rows.removeAt(0);
        for (String row in rows) {
          // print(row);
          List<dynamic> columns = row.split(','); // Split each row into columns
          // print(columns);
          Map<String, dynamic> rowData = {};
          for(int i = 0; i < columnNames.length; i++)
            {
              rowData[columnNames[i]] = double.parse(columns[i]);
            }
          uploadedData.add(rowData);
        }
        if(uploadedData.isEmpty)
          {
            print('ahhahahahha');
          }

        print(uploadedData[0]["Age"]);
      } catch (e) {
        print('Error reading CSV file: $e');
        print(uploadedData);
      }
    } else {
      // User canceled the file selection
    }
  }

  Future<void> _predictResults() async {
    List<String> results = [];

    for (var row in uploadedData) {
      String prediction = await _predict(row);
      results.add(prediction);
    }

    setState(() {
      for (var i = 0; i < uploadedData.length; i++) {
        uploadedData[i]['Result'] = results[i];
      }
    });
  }

  Future<String> _predict(Map<String, dynamic> rowData) async {
    final url = 'http://10.0.2.2:5000/predict';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(rowData),
      );

      if (response.statusCode == 200) {
        String prediction = json.decode(response.body)['result'].toString();
        return prediction;
      } else {
        return 'Error';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error';
    }
  }

  Future<void> _downloadFile() async {
    String? directory = await FilePicker.platform.getDirectoryPath();
    final downloadPath = '${directory}/downloaded_file.csv';

    List<List<dynamic>> updatedData = uploadedData
        .map((map) => map.values.toList()) // Convert each map to a list of values
        .toList();

    // Convert the updated data to CSV format
    String csvData = const ListToCsvConverter().convert(updatedData);

    // Save the CSV data to the downloadPath
    final file = File(downloadPath);
    await file.writeAsString(csvData);
    await FlutterDownloader.enqueue(
      url: '',
      savedDir: directory.toString(),
      fileName: 'downloaded_file.csv',
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CardiAlert"),
        elevation: .1,
        backgroundColor: Colors.blue
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              if (uploadedData.isEmpty)
                makeDashboardItem("Upload File", Icons.upload_file, () {
                  _uploadFile();
                }),
                makeDashboardItem(
                    "Predict", Icons.online_prediction_outlined, () {
                  _predictResults();
                  Fluttertoast.showToast(
                      msg: 'Presence',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.mainColor,
                      textColor: Colors.white,
                      fontSize: 10.0);
                }),
                makeDashboardItem("Download", Icons.download, () {
                  _downloadFile();
                }),
                makeDashboardItem("Upload Another File", Icons.upload, () {
                  _uploadFile();
                }),
                // makeDashboardItem("Alphabet", Icons.alarm),
              // makeDashboardItem("Alphabet", Icons.alarm)
            ],
          ),
        ),
      );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Upload Test'),
    //   ),
    //   body: Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [
    //           hexStringToColor("4cb4d5"),
    //           hexStringToColor("52afff"),
    //           hexStringToColor("3282d4"),
    //         ],
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //       ),
    //     ),
    //     child: SingleChildScrollView(
    //       child: Padding(
    //         padding: EdgeInsets.fromLTRB(
    //           20,
    //           MediaQuery.of(context).size.height * 0.2,
    //           20,
    //           0,
    //         ),
    //         child: Column(
    //           children: <Widget>[
    //             logoWidget("assets/images/logo2.png"),
    //             const SizedBox(
    //               height: 30,
    //             ),
    //             if (uploadedData.isEmpty)
    //               ElevatedButton(
    //                 onPressed: _uploadFile,
    //                 child: Text('Upload File'),
    //               )
    //               ,
    //               Column(
    //                 children: [
    //                   Text(
    //                     'CardiAlert',
    //                     style: TextStyle(
    //                       fontSize: 24,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //
    //                   SizedBox(height: 20),
    //                   ElevatedButton(
    //                     onPressed: _predictResults,
    //                     child: Text('Predict'),
    //                   ),
    //                   ElevatedButton(
    //                     onPressed: _downloadFile,
    //                     child: Text('Download'),
    //                   ),
    //                   ElevatedButton(
    //                     onPressed: _uploadFile,
    //                     child: Text('Upload Another File'),
    //                   ),
    //                 ],
    //               ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }



  // Widget logoWidget(String imagePath) {
  //   return Image.asset(
  //     imagePath,
  //     width: 100,
  //     height: 100,
  //   );
  // }
  //
  // Color hexStringToColor(String hexColor) {
  //   final hexCode = hexColor.replaceAll('#', '');
  //   return Color(int.parse('FF$hexCode', radix: 16));
  // }

  Card makeDashboardItem(String title, IconData icon,VoidCallback onTap) {
    return Card(
      elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}


