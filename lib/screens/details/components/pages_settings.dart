import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
Color TrackColor = const Color(0xFFF5EC42);
List<Color> ProgressBarColors = [Color(0xFFf03118),Color(0xFFC2DB07),Color(0xFF17A60D)];
final slider = SleekCircularSlider(
                      appearance: CircularSliderAppearance(customColors:CustomSliderColors(trackColor:TrackColor,progressBarColors:ProgressBarColors),
                      customWidths: CustomSliderWidths(progressBarWidth: 25),
                      size:200),
                      onChange: (double value) {
                        print(value);
                      });

final controller = PageController(initialPage: 0);
class BasicSettings extends StatelessWidget {
  
  const BasicSettings({
    Key key,
    @required this.size,
    this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      // the height of this container is 80% of our width
      height: size.width * 0.8,
      child: PageView(
      controller:controller,
      children: <Widget>[
        slider,
        slider
      ],
    ));
    
  }
}
