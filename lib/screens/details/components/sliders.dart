import 'dart:convert';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bbClock/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bbClock/models/fileIO.dart';

bool block = false;
var client;
bool isReady = false;
Color TrackColor = const Color(0xFFF5EC42);
List<Color> ProgressBarColors = [
  Color(0xFFefff42),
  Color(0xb0b4ff63),
  Color(0x9c08450a)
];

final brightness = SleekCircularSlider(
  initialValue: alldata['settings']['brightness'].toDouble(),
  appearance: CircularSliderAppearance(
      customColors: CustomSliderColors(
          trackColor: TrackColor,
          progressBarColors: ProgressBarColors,
          shadowColor: Color(0xcffff9),
          shadowMaxOpacity: 0.02),
      customWidths: CustomSliderWidths(progressBarWidth: 25),
      size: 300),
  onChangeStart: (double value) {
    isReady = true;
    // client = http.Client();
  },
  onChange: (double value) async {
    if (isReady) wschannel.sink.add("b" + value.round().toString());
  },
  onChangeEnd: (double endValue) async {
    // ucallback providing an ending value (when a pan gesture ends)
    isReady = false;
    alldata['settings']['brightness'] = endValue.round();
    String alldataString = jsonEncode(alldata);
    FileIO().writeData(alldataString);
    var response = await http
        .post("http://bbclock.lan/update", body: {'d': alldataString});
    if (response.statusCode == 200) {
      print("OK");
      Fluttertoast.showToast(
          msg: " 保存成功 ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[200],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  },
);

/// Example 09
final customWidth09 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 15, shadowWidth: 50);
final customColors09 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.5),
    trackColor: Color(0x000000).withOpacity(0.1),
    progressBarColors: [
      Color(0x3586FC).withOpacity(0.1),
      Color(0xFF8876).withOpacity(0.25),
      Color(0x3586FC).withOpacity(0.5)
    ],
    shadowColor: Color(0x133657),
    shadowMaxOpacity: 0.02);

final CircularSliderAppearance appearance09 = CircularSliderAppearance(
    customWidths: customWidth09,
    customColors: customColors09,
    startAngle: 55,
    angleRange: 110,
    size: 300,
    counterClockwise: true);

final volume = SleekCircularSlider(
  initialValue: alldata['settings']['volume'].toDouble(),
  appearance: appearance09,
  onChangeStart: (double value) {
    isReady = true;
    // client = http.Client();
  },
  onChange: (double value) async {
    wschannel.sink.add("v" + value.round().toString());
  },
);
