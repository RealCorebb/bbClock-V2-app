import 'package:flutter/material.dart';
import 'package:bbClock/components/search_box.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:bbClock/screens/details/details_screen.dart';
import 'package:bbClock/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'setting_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {}),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  // here we use our demo procuts list
                  itemCount: settings.length,
                  itemBuilder: (context, index) => SettingCard(
                    itemIndex: index,
                    setting: settings[index],
                    press: () {
                      if (wsbool == true)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              index: index,
                            ),
                          ),
                        );
                      else
                        Fluttertoast.showToast(
                            msg: "尚未连接上设备",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
