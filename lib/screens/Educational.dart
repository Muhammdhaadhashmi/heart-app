import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/text_view.dart';

class ResourcesScreen extends StatelessWidget {
  final List<Resource> resources = [
    Resource(
      title: '1) Heart Disease Resources for Health Professionals',
      url: 'https://www.cdc.gov/heartdisease/educational_materials.htm',
    ),
    Resource(
      title: '2) Patient Education Resources for Health Care Professionals',
      url: 'https://www.heart.org/en/health-topics/consumer-healthcare/patient-education-resources-for-healthcare-providers',
    ),
    Resource(
      title: '3) Heart disease - resources',
      url: 'https://medlineplus.gov/ency/article/002203.htm',
    ),
    Resource(
      title: '4) Education of the Patients Living with Heart Disease',
      url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8116090/',
    ),
    Resource(
      title: '5) Cardiac Patient Education Tools and Handouts',
      url: 'https://pcna.net/clinical-resources/patient-handouts/',
    ),
    Resource(
      title: '6) Online resources for heart disease',
      url: 'https://journals.lww.com/nursing/Citation/2016/02000/Online_resources_for_heart_disease.21.aspx',
    ),
    // Add more resources as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Resources'),
      ),
      body: Container(
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
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: logoWidget("assets/images/logo2.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextView(text: "Click below Given Resources For Information:",fontSize: 20,color: Colors.white,),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  final resource = resources[index];
                  return ListTile(
                    title: InkWell(
                      child: Text(
                        resource.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () => _launchInBrowser(Uri.parse(resource.url)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class Resource {
  final String title;
  final String url;

  Resource({required this.title, required this.url});
}

Color hexStringToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}



Widget logoWidget(String imagePath) {
  return Image.asset(
    imagePath,
    width: 155,
    height: 155,
  );
}
