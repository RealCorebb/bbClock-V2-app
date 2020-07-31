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
