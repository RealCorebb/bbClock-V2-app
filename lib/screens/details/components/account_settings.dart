import 'dart:convert';

import 'package:bbClock/models/fileIO.dart';
import 'package:bbClock/screens/details/components/interactive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/main.dart';
import 'package:bbClock/models/settings.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'pickerData.dart';

final controller = PageController(initialPage: 0);
Size size;

class AccountSettingsWidget extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettingsWidget> {
  final cityCon = TextEditingController();
  final daysCon = TextEditingController();
  final biliCon = TextEditingController();
  final weiboCon = TextEditingController();
  final youtubeCon = TextEditingController();
  final insCon = TextEditingController();
  final githubCon = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cityCon.text = alldata['settings']['location'];
    biliCon.text = alldata['accounts']['bilibili'];
    weiboCon.text = alldata['accounts']['weibo'];
    youtubeCon.text = alldata['accounts']['youtube'];
    insCon.text = alldata['accounts']['instagram'];
    githubCon.text = alldata['accounts']['github'];
    daysCon.text = alldata['accounts']['days'];
  }

  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
        bottom: false,
        child: PageView(
          controller: controller,
          children: <Widget>[
            _accountSettings(),
          ],
        ));
  }

  showPickerDialog(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerData)),
        hideHeader: true,
        title: new Text("城市选择"),
        onConfirm: (Picker picker, List value) {
          cityCon.text = value.toString();
        }).showDialog(context);
  }

  _accountSettings() {
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
                TextField(
                  controller: cityCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/city.svg",
                      height: 38,
                    ),
                    hintText: '城市拼音',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: biliCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/bilibili-fill.svg",
                      height: 38,
                      color: Colors.lightBlue,
                    ),
                    hintText: 'Bilibili (UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: weiboCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/weibo.svg",
                      height: 38,
                    ),
                    hintText: '微博(UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: youtubeCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/youtube.svg",
                      height: 38,
                    ),
                    hintText: 'Youtube(UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: insCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/instagram.svg",
                      height: 38,
                    ),
                    hintText: 'Instagram(UID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: githubCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/github.svg",
                      height: 38,
                    ),
                    hintText: 'Github(ID)',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                /*
                TextField(
                  controller: daysCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    icon: SvgPicture.asset(
                      "assets/icons/heart.svg",
                      height: 38,
                    ),
                    hintText: '计数日时间戳',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),*/
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
                  alldata['settings']['location'] = cityCon.text;
                  alldata['accounts']['bilibili'] = biliCon.text;
                  alldata['accounts']['weibo'] = weiboCon.text;
                  alldata['accounts']['youtube'] = youtubeCon.text;
                  alldata['accounts']['instagram'] = insCon.text;
                  alldata['accounts']['github'] = githubCon.text;
                  // alldata['accounts']['days'] = daysCon.text;
                  String alldataString = jsonEncode(alldata);
                  file.writeData(alldataString);
                  var formData = FormData.fromMap({
                    'file': MultipartFile.fromString(alldataString,
                        filename: 'alldata.json')
                  });
                  var dio = Dio();

                  var response = new Response(); //Response from Dio
                  response =
                      await dio.put("http://bbclock.lan", data: formData);

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
}
