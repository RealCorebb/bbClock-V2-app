import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';

import 'basic_settings.dart';
import 'chat_and_add_to_cart.dart';
import 'list_of_colors.dart';
import 'basic_settings.dart';
final controller = PageController(initialPage: 0);
Size size;
class Body extends StatelessWidget {

  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      bottom: false,
      child: PageView(
      controller:controller,
      children: <Widget>[
        _brightness(),
        _brightness()
      ],
    ));
  }
  _brightness(){
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
                  Center(
                    heightFactor:1.2,
                    child: brightness
                  ),
                  ListOfColors(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      '亮度调整',
                      //style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      '您可以在这里调整屏幕的亮度，也可以勾选自动亮度，根据环境自动调整',
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            ChatAndAddToCart(),
          ],
        ),
      );
}
}
