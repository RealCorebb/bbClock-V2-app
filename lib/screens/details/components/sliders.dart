import 'package:flutter/material.dart';
import 'package:bbClock/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

bool block = false;
var client;
bool isReady = false;
Color TrackColor = const Color(0xFFF5EC42);
List<Color> ProgressBarColors = [
  Color(0xFFf03118),
  Color(0xFFC2DB07),
  Color(0xFF17A60D)
];
var wschannel = bbClock.ws;

final brightness = SleekCircularSlider(
  appearance: CircularSliderAppearance(
      customColors: CustomSliderColors(
          trackColor: TrackColor, progressBarColors: ProgressBarColors),
      customWidths: CustomSliderWidths(progressBarWidth: 25),
      size: 350),
  onChangeStart: (double value) {
    isReady = true;
    // client = http.Client();
  },
  onChange: (double value) async {
    wschannel.send("b" + value.round().toString());
  },
);
