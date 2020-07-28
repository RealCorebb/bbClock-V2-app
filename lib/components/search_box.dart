import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';

var wsstatus = TextEditingController();

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 top and bottom
      ),
      decoration: BoxDecoration(),
      child: TextField(
        enabled: false,
        controller: wsstatus,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 5, bottom: 11, top: 11, right: 15),
          icon: Lottie.asset(
            'assets/icons/connection.json',
            height: 36,
          ),
          hintText: '正在尝试连接设备',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
