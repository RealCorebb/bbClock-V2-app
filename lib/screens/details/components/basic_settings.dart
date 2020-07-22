import 'package:bbClock/screens/details/components/interactive.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';

import 'sliders.dart';
import 'sliders.dart';

final controller = PageController(initialPage: 0);
Size size;

class BasicSettingsWidget extends StatefulWidget {
  @override
  _BasicSettingsState createState() => _BasicSettingsState();
}

class _BasicSettingsState extends State<BasicSettingsWidget> {
  bool _autoNextPage = false;
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
        bottom: false,
        child: PageView(
          controller: controller,
          children: <Widget>[_brightness(), _volume(), _extraSettings()],
        ));
  }

  _brightness() {
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
                Center(heightFactor: 1.2, child: brightness),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '亮度调整',
                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '您可以在这里调整屏幕的亮度，也可以勾选自动亮度，根据环境自动调整',
                    style: TextStyle(color: kTextLightColor),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
          autoBrightnessWidget(),
        ],
      ),
    );
  }

  _volume() {
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
                Center(heightFactor: 1.2, child: volume),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '音量调整',
                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '您可以在这里调整音量',
                    style: TextStyle(color: kTextLightColor),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ],
      ),
    );
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
                new Row(children: <Widget>[
                  Text(
                    '自动翻页',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Switch(
                      value: _autoNextPage,
                      onChanged: (val) {
                        setState(() {
                          _autoNextPage = val;
                          print(_autoNextPage);
                        });
                      }),
                ]),
                Text(
                  '翻页间隔',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  '手势启用',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
