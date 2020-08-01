import 'dart:convert';

import 'package:bbClock/main.dart';
import 'package:bbClock/models/fileIO.dart';
import 'package:bbClock/screens/details/components/interactive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'sliders.dart';

final controller = PageController(initialPage: 0);
Size size;

class BasicSettingsWidget extends StatefulWidget {
  @override
  _BasicSettingsState createState() => _BasicSettingsState();
}

class _BasicSettingsState extends State<BasicSettingsWidget> {
  bool _autoNextPage = true;
  bool _isGestureOn = true;
  bool _isAutoBrightness = true;
  bool _autoInMusic = true;
  double _interval = 10;
  int _brightnessvalue = 50;
  int _volumevalue = 50;
  Response response;
  Dio dio = new Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isAutoBrightness = alldata['settings']['autobrightness'];
    _brightnessvalue = alldata['settings']['brightness'];
    _volumevalue = alldata['settings']['volume'];
    _autoNextPage = alldata['settings']['autoNextPage'];
    _isGestureOn = alldata['settings']['isGestureOn'];
    _autoInMusic = alldata['settings']['autoInMusic'];
    _interval = alldata['settings']['interval'].toDouble();
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
          children: <Widget>[_brightness(), _volume(), _extraSettings()],
        ));
  }

  _brightness() {
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
                  heightFactor: 1.2,
                  child: SleekCircularSlider(
                    initialValue: _brightnessvalue.toDouble(),
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
                      if (isReady)
                        wschannel.sink.add("b" + value.toInt().toString());
                    },
                    onChangeEnd: (double endValue) async {
                      // ucallback providing an ending value (when a pan gesture ends)
                      isReady = false;
                      alldata['settings']['brightness'] = endValue.toInt();
                      String alldataString = jsonEncode(alldata);
                      FileIO().writeData(alldataString);
                      /*
                      var uri = Uri.parse("http://bbclock.lan/upload");
                      var request = new MultipartRequest("POST", uri);
                      print('${FileIO().localPath}/alldata.json');
                      
                      var multipartFile = await MultipartFile.fromPath(
                          "package", '${FileIO().localPath.then((value) => null)}/alldata.json');
                      request.files.add(multipartFile);
                      StreamedResponse response = await request.send();
                      response.stream.transform(utf8.decoder).listen((value) {
                        print(value);
                      });
                      */
                      /*
                      var response = await http.post(
                          "http://bbclock.lan/update",
                          body: {'d': alldataString});
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
                      }*/
                      FormData formData = FormData.fromMap({
                        "file": await MultipartFile.fromFile(
                            '${FileIO().localPath}/alldata.json',
                            filename: "sb.json")
                      });
                      response =
                          await dio.post("http://bbclock.lan", data: formData);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '亮度调整',
                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '您可以在这里调整屏幕的亮度，也可以勾选自动亮度，根据环境自动调整',
                    style: TextStyle(color: kTextLightColor),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFCBF1E),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Icon(
                    Icons.brightness_medium,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                Text(
                  '自动亮度',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                Switch(
                    value: _isAutoBrightness,
                    onChanged: (val) async {
                      setState(() {
                        _isAutoBrightness = val;
                      });
                      FileIO file = new FileIO();
                      alldata['settings']['autobrightness'] = _isAutoBrightness;
                      String alldataString = jsonEncode(alldata);
                      file.writeData(alldataString);
                      /*
                      var response = await http.post(
                          "http://bbclock.lan/update",
                          body: {'d': alldataString});
                      if (response.statusCode == 200) {
                        print("OK");
                        Fluttertoast.showToast(
                            msg: " 保存成功 ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue[200],
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }*/
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  _volume() {
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
                  heightFactor: 1.2,
                  child: SleekCircularSlider(
                    initialValue: _volumevalue.toDouble(),
                    appearance: appearance09,
                    onChangeStart: (double value) {
                      isReady = true;
                      // client = http.Client();
                    },
                    onChange: (double value) async {
                      wschannel.sink.add("v" + value.toInt().toString());
                    },
                    onChangeEnd: (double endValue) async {
                      // ucallback providing an ending value (when a pan gesture ends)
                      isReady = false;
                      alldata['settings']['volume'] = endValue.toInt();
                      String alldataString = jsonEncode(alldata);
                      FileIO().writeData(alldataString);
                      /*
                      var response = await http.post(
                          "http://bbclock.lan/update",
                          body: {'d': alldataString});
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
                      }*/
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '音量调整',
                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '您可以在这里调整音量',
                    style: TextStyle(color: kTextLightColor),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _extraSettings() {
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
                new Row(children: <Widget>[
                  Icon(
                    Icons.pan_tool,
                    color: Colors.teal,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    '手势启用',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Switch(
                      value: _isGestureOn,
                      onChanged: (val) {
                        setState(() {
                          _isGestureOn = val;
                        });
                      }),
                ]),
                new Row(children: <Widget>[
                  Icon(
                    Icons.autorenew,
                    color: Colors.teal,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    '自动翻页',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Switch(
                      value: _autoNextPage,
                      onChanged: (val) {
                        setState(() {
                          _autoNextPage = val;
                          print(_autoNextPage);
                        });
                      }),
                ]),
                new Row(children: <Widget>[
                  Icon(
                    Icons.update,
                    color: Colors.teal,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    '翻页间隔',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Slider(
                      label: _interval.toString(),
                      divisions: 23,
                      value: _interval,
                      onChanged: (val) {
                        setState(() {
                          _interval = val.round().toDouble();
                          print(_interval);
                        });
                      },
                      min: 5,
                      max: 120)
                ]),
                new Row(children: <Widget>[
                  Icon(
                    Icons.music_video,
                    color: Colors.teal,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    '自动进入音乐界面',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Switch(
                      value: _autoInMusic,
                      onChanged: (val) {
                        setState(() {
                          _autoInMusic = val;
                        });
                      }),
                ]),
                new Row(children: <Widget>[
                  Icon(
                    Icons.location_city,
                    color: Colors.teal,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    '城市',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Switch(
                      value: _autoInMusic,
                      onChanged: (val) {
                        setState(() {
                          _autoInMusic = val;
                        });
                      }),
                ]),
                SizedBox(height: kDefaultPadding),
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
                  alldata['settings']['brightness'] = _brightnessvalue;
                  alldata['settings']['volume'] = _volumevalue;
                  alldata['settings']['autoNextPage'] = _autoNextPage;
                  alldata['settings']['isGestureOn'] = _isGestureOn;
                  alldata['settings']['autoInMusic'] = _autoInMusic;
                  alldata['settings']['interval'] = _interval;
                  String alldataString = jsonEncode(alldata);
                  file.writeData(alldataString);
                  /*
                  var response = await http.post("http://bbclock.lan/update",
                      body: {'d': alldataString});
                  if (response.statusCode == 200) {
                    print("OK");
                    Fluttertoast.showToast(
                        msg: " 保存成功 ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue[200],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }*/
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
