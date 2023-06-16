import 'package:firebase_signin/utils/text_view.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: TextView(text: "Contact Page",)
      ),
      body: Container(
            child:Column(
              children: [
                SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: TextView(text: " Name : Muhammad Abrar",fontSize: 30,color: Colors.blue,)
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: TextView(text: " Phone : +447553067167",fontSize: 30,color: Colors.blue,)
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: TextView(text: " Gmail: wahla6568@gmail.com",fontSize: 30,color: Colors.blue,)
                  ),
                ),
              ],
            ),
          )
    );
  }
}
