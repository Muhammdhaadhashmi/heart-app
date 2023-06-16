import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Utils/dimensions.dart';
import '../../../../Utils/text_view.dart';
import '../../../screens/signin_screen.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/spaces.dart';

class SettingListItem extends StatefulWidget {
  final itemData;

  SettingListItem({required this.itemData});

  @override
  State<SettingListItem> createState() => _SettingListItemState();
}

class _SettingListItemState extends State<SettingListItem> {
  String userName = "";
  showProfile() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: Dimensions.screenHeight(context),
          width: Dimensions.screenWidth(context),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Material(
              child: Container(
                height: 240,
                width: Dimensions.screenWidth(context) - 100,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: AppColors.grey, blurRadius: 4)
                ], color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Profile",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    AddVerticalSpace(20),
                    TextView(
                      text: "Name : Muhammad Abrar",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                    ),
                    TextView(
                      text:
                          "Email : wahla6568@gmail.com",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                    ),
                    AddVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: TextView(
                            text: "Ok",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        if (widget.itemData["title"] == "Profile") {
          showProfile();
        }
        else {
          await FirebaseAuth.instance.signOut();
          Get.offAll(
            SignInScreen(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 600),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: 70,
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: AppColors.grey, blurRadius: 4, offset: Offset(0, 4))
            ]
            // border: Border.all(color: AppColors.black, width: 2),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddHorizontalSpace(20),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.itemData["icon"],
                  ),
                ),
              ),
            ),
            AddHorizontalSpace(10),
            TextView(
              text: widget.itemData["title"],
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
