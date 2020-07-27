import 'package:bbClock/screens/details/components/interactive.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:flutter_svg/svg.dart';

final controller = PageController(initialPage: 0);
Size size;

class AccountSettingsWidget extends StatelessWidget {
  bool _autoNextPage = true;
  bool _isGestureOn = true;
  bool _autoInMusic = true;
  double _interval = 10;
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
        bottom: false,
        child: PageView(
          controller: controller,
          children: <Widget>[_accountSettings()],
        ));
  }

  _accountSettings() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(50, 30, 50, 50),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/bilibili-fill.svg",
                      height: 38,
                      color: Colors.lightBlue,
                    ),
                    hintText: 'Bilibili (UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/weibo.svg",
                      height: 38,
                    ),
                    hintText: '微博(UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/youtube.svg",
                      height: 38,
                    ),
                    hintText: 'Youtube(UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/instagram.svg",
                      height: 38,
                    ),
                    hintText: 'Instagram(UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/github.svg",
                      height: 38,
                    ),
                    hintText: 'Github(ID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
