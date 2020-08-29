import 'dart:convert';

import 'package:bbClock/main.dart';
import 'package:bbClock/models/fileIO.dart';
import 'package:bbClock/screens/details/components/interactive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

final controller = PageController(initialPage: 0);
Size size;
bool isAP = false;
class AdvancedSettingsWidget extends StatefulWidget {
  
  @override
  _AdvancedSettingsState createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettingsWidget> {
  final myController = TextEditingController();

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.text = alldata['settings']['NetworkAddress'];
    
  }

  @override
  Widget build(BuildContext context) {
    // it provide us total height and width

    size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: SafeArea(
          bottom: false,
          child: PageView(
            controller: controller,
            children: <Widget>[_advancedSettings()],
          )),
    );
  }

  _advancedSettings() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(50, 30, 50, 50),
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
                Row(
                  children: <Widget>[
                    Text('连接模式(STA/AP)',
                        style: TextStyle(color: kTextLightColor, fontSize: 18)),
                    Spacer(),
                    Switch(
                        activeColor: Colors.green,
                        inactiveTrackColor: Colors.lightBlue,
                        value: isAP,
                        onChanged: (value) {
                          setState(() {
                            isAP = value;
                            print(isAP);
                          });
                        }),
                  ],
                ),
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/device.svg",
                      height: 38,
                    ),
                    hintText: 'bbClock.lan',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.teal)),
                height: 60.0,
                minWidth: 300.0,
                onPressed: () async {
                  FileIO file = new FileIO();
                  print(alldata['settings']['NetworkMode']);
                  print(alldata['settings']['NetworkAddress']);
                  alldata['settings']['NetworkAddress'] = myController.text;
                  if (isAP)
                    alldata['settings']['NetworkMode'] = "AP";
                  else
                    alldata['settings']['NetworkMode'] = "STA";

                  print(alldata['settings']['NetworkMode']);
                  print(alldata['settings']['NetworkAddress']);
                  String alldataString = jsonEncode(alldata);
                  file.writeData(alldataString);
                  var formData = FormData.fromMap({
                    'file': MultipartFile.fromString(alldataString,
                        filename: 'alldata.json')
                  });
                  var dio = Dio();

                  var response = new Response(); //Response from Dio
                  response =
                      await dio.put("http://$bbclockURL", data: formData);

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
                child: Text(
                  "保存设置",
                  style: new TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.greenAccent,
                textColor: Colors.white,
                splashColor: Colors.teal[50],
              ),
            ),
          ),
        ],
      ),
    );
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
    );
  }
}
