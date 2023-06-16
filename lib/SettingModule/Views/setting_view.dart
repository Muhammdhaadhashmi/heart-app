import 'package:flutter/material.dart';
import '../../../Utils/text_view.dart';
import '../../utils/app_colors.dart';
import 'Components/setting_list_item.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  List settings = [
    {
      "title": "Profile",
      "icon": "assets/images/profile.png",
    },
    {
      "title": "Log out",
      "icon": "assets/images/logout.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: TextView(text: "Settings"),
      ),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return SettingListItem(itemData: settings[index]);
        },
      ),
    );
  }
}
