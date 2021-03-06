import 'package:bbClock/screens/details/components/account_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:bbClock/screens/details/components/page_settings.dart';

import 'components/basic_settings.dart';

class DetailsScreen extends StatelessWidget {
  final int index;

  const DetailsScreen({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(context),
        body: BasicSettingsWidget(),
      );
    } else if (index == 1) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(context),
        body: PagesSettingsWidget(),
      );
    } else if (index == 2) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(context),
        body: AccountSettingsWidget(),
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        '返回'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      /*
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/cart_with_item.svg'),
          onPressed: () {},
        ),
      ],*/
    );
  }
}
