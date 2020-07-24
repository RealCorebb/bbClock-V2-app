import 'package:bbClock/screens/details/components/interactive.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:flutter_svg/svg.dart';

import 'sliders.dart';
import 'sliders.dart';

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
          children: <Widget>[_extraSettings()],
        ));
  }

  _extraSettings() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: SvgPicture.asset("assets/icons/search.svg"),
                    hintText: '正在尝试连接设备',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: SvgPicture.asset("assets/icons/search.svg"),
                    hintText: '正在尝试连接设备',
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
