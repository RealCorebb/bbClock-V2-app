import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class autoBrightnessWidget extends StatefulWidget {
  @override
  _autoBrightnessState createState() => _autoBrightnessState();
}

class _autoBrightnessState extends State<autoBrightnessWidget> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Icon(
              Icons.brightness_medium,
              color: Colors.white,
              size: 24.0,
            ),
          ),
          Text(
            '自动亮度',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Spacer(),
          Switch(
              value: _value,
              onChanged: (val) {
                setState(() {
                  _value = val;
                  print(_value);
                });
              })
        ],
      ),
    );
  }
}
