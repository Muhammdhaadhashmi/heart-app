import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screens/Appointment.dart';
import 'package:firebase_signin/screens/signin_screen.dart';
import 'package:firebase_signin/screens/takenotes.dart';
import 'package:firebase_signin/screens/uploadtests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Contact_Screen.dart';
import '../SettingModule/Views/setting_view.dart';
import 'Educational.dart';
import 'inputfields.dart';
import 'medication.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Abrar!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Good Morning', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo2.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Input Fields', Icons.input, Colors.deepOrange,(){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InputFieldsScreen()),
                        );
                  }),
                  itemDashboard('Upload Dataset', CupertinoIcons.add_circled, Colors.purple,(){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UploadTestScreen()),
                        );
                  }),
                  itemDashboard('Medication', Icons.alarm, Colors.brown,(){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MedicationReminderScreen()),
                        );
                  }),
                  itemDashboard('Appointment', Icons.alarm_add_rounded, Colors.brown,(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentReminderScreen()),
                    );
                  }),
                  itemDashboard('Manage Notes', Icons.note_alt_sharp, Colors.indigo,(){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotesScreen()),
                        );
                  }),
                  itemDashboard('Educational', Icons.note, Colors.teal,(){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResourcesScreen()),
                        );
                  }),
                  itemDashboard('Settings', Icons.settings, Colors.blue,(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingView()),
                    );
                  }),
                  itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent,(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactScreen()),
                    );
                  }),
                  itemDashboard('Log Out', Icons.logout, Colors.teal,(){
                    FirebaseAuth.instance.signOut().then((value) {
                          print("Signed Out");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()),
                          );
                        });
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background,VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white)
          ),
          const SizedBox(height: 8),
          Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium)
        ],
      ),
    ),
  );
}





//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_signin/screens/Appointment.dart';
// import 'package:firebase_signin/screens/Educational.dart';
// import 'package:firebase_signin/screens/medication.dart';
// import 'package:firebase_signin/screens/signin_screen.dart';
// import 'package:firebase_signin/screens/takenotes.dart';
// import 'package:firebase_signin/screens/uploadtests.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_signin/screens/inputfields.dart';
// import 'package:firebase_signin/screens/Educational.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               hexStringToColor("4cb4d5"),
//               hexStringToColor("52afff"),
//               hexStringToColor("3282d4"),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(top: 20, bottom: 0),
//               child: Image.asset(
//                 "assets/images/logo2.png",
//                 width: 200,
//                 height: 200,
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       child: Text("Logout"),
//                       onPressed: () {
//                         FirebaseAuth.instance.signOut().then((value) {
//                           print("Signed Out");
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => SignInScreen()),
//                           );
//                         });
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       child: Text("Input Fields"),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => InputFieldsScreen()),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       child: Text("Upload Dataset"),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => UploadTestScreen()),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       child: Text("Set Medication Reminder"),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MedicationReminderScreen()),
//                         );
//                       },
//                     ),SizedBox(height: 20),
//                     ElevatedButton(
//                       child: Text("Set Appointment Reminder"),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => AppointmentReminderScreen()),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       child: Text("Manage Notes"),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => NotesScreen()),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       child: Text("Educational Resources"),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => ResourcesScreen()),
//                         );
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Color hexStringToColor(String hexString) {
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }
// }
//
//
