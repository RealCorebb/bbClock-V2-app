import 'package:bbClock/screens/details/components/account_settings.dart';
import 'package:bbClock/screens/details/components/advanced_settings.dart';
import 'package:bbClock/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bbClock/constants.dart';

import 'components/body.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('bbClock控制台'),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/settings.svg",
            color: Colors.teal[50],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdvancedSettingsWidget(),
              ),
            );
          },
        ),
      ],
    );
  }
}
