import 'dart:async';
import 'dart:convert';

import 'package:bbClock/main.dart';
import 'package:bbClock/models/fileIO.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback

class PagesSettingsWidget extends StatefulWidget {
  @override
  _PagesSettingsState createState() => _PagesSettingsState();
}

class _PagesSettingsState extends State<PagesSettingsWidget> {
  String alldatapath;
  Response response;
  Dio dio = new Dio();
  List<Hexcolor> textColors = [];
  List<int> pageSortList = [];
  List<int> pageSwitchEnable = [];
  List<int> pageShowList = [];
  bool debounceActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < allpages.length; i++) {
      textColors.add(Hexcolor(
          '#${alldata['pages']['${alldata['pageslist'][i]}']['color']}'));
      if (alldata['pageslist'][i] <= 6 && alldata['pageslist'][i] >= 1) {
        pageSortList.add(1);
        pageSwitchEnable.add(1);
      } else if (alldata['pageslist'][i] <= 26 &&
          alldata['pageslist'][i] >= 21) {
        pageSortList.add(21);
        pageSwitchEnable.add(21);
      } else {
        pageSortList.add(int.parse('${alldata['pageslist'][i]}'));
        pageSwitchEnable.add(int.parse('${alldata['pageslist'][i]}'));
      }
    }
    for (var pp in alldata['pages'].keys) {
      if ((int.parse(pp) <= 6 && int.parse(pp) >= 2) ||
          (int.parse(pp) <= 26 && int.parse(pp) >= 22)) {
      } else if (pageSortList.contains(int.parse(pp)) == false)
        pageSortList.add(int.parse(pp));
    }
    FileIO().localPath.then((String result) {
      setState(() {
        alldatapath = result;
      });
    });
  }

  void changeColor(Color color) async {
    if (debounceActive) return null;
    debounceActive = true;
    await Future.delayed(Duration(milliseconds: 50));
    debounceActive = false;
    print(color.toString().split('(0xff')[1].split(')')[0]);
    wschannel.sink.add("!c" + color.toString().split('(0xff')[1].split(')')[0]);
    setState(() {
      textColors[controller.page.round()] =
          Hexcolor('#${color.toString().split('(0xff')[1].split(')')[0]}');
    });

    alldata['pages']['${alldata['pageslist'][controller.page.round()]}']
        ['color'] = color.toString().split('(0xff')[1].split(')')[0];
  }

  final screenPagecontroller = PageController(initialPage: 0);
  final controller = PageController(initialPage: page);
  List<dynamic> allpages = alldata['pageslist'];
  @override
  @override
  Widget build(BuildContext context) {
    streamController.stream.listen(
      (dynamic message) async {
        page = int.parse(message);
        if (controller.hasClients)
          controller.animateToPage(page,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
    return SafeArea(
        bottom: false,
        child: PageView(
          controller: screenPagecontroller,
          children: <Widget>[_pageControl(), _reorderPage()],
        ));
  }

  _pageControl() {
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
                Stack(
                  children: <Widget>[
                    Container(
                        width: 1280,
                        height: 320,
                        child: Image(
                            // filterQuality: ,
                            image: AssetImage(
                                "assets/images/page_background.png"))),
                    Container(
                      child: Row(),
                    ),
                    Container(
                      width: 1280,
                      height: 320,
                      child: PageView(
                        physics: new NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: <Widget>[
                          //RaisedButton(),
                          for (var i = 0; i < allpages.length; i++)
                            new Container(
                                child: Row(
                              children: <Widget>[
                                if (i != 0)
                                  Container(
                                      //padding: EdgeInsets.only(top: 10),
                                      width: 80,
                                      //color: Colors.green,
                                      child: Image(
                                          filterQuality: FilterQuality.none,
                                          image: NetworkImage(
                                              'http://bbclock.lan/gifs/${alldata['pageslist'][i]}.gif'),
                                          fit: BoxFit.fitWidth)),
                                InkWell(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        titlePadding: const EdgeInsets.all(0.0),
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: currentColor,
                                            onColorChanged: changeColor,
                                            colorPickerWidth: 300.0,
                                            pickerAreaHeightPercent: 0.7,
                                            enableAlpha: false,
                                            displayThumbColor: true,
                                            showLabel: true,
                                            paletteType: PaletteType.hsv,
                                            pickerAreaBorderRadius:
                                                const BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(2.0),
                                              topRight:
                                                  const Radius.circular(2.0),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  child: Container(
                                    child: Text(
                                      ' ${alldata['pages']['${alldata['pageslist'][i]}']['text'][0]}',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        //color: Hexcolor(
                                        // '#${alldata['pages']['${alldata['pageslist'][i]}']['color']}'),
                                        color: textColors[i],
                                        fontSize: 88,
                                        fontFamily: 'PixelCorebb',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                        ],
                      ),
                    ),
                  ],
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          wschannel.sink.add("!f");
                          if (controller.hasClients)
                            controller.previousPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.ease);
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF42A5F5),
                                Color(0xFF1976D2),
                                Color(0xFF0D47A1),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.arrow_back, size: 24),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          wschannel.sink.add("!p");
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF0D47A1),
                                Color(0xFF0D47A1),
                              ],
                            ),
                          ),
                          child: Icon(Icons.pause, size: 24),
                          padding: const EdgeInsets.all(5.0),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          wschannel.sink.add("!n");
                          if (controller.hasClients)
                            controller.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.ease);
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.arrow_forward, size: 24),
                        ),
                      ),
                    ]),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '页面设置',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Text(
                    '在这里涂鸦、设置页面的文字颜色',
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

  _reorderPage() {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: ReorderableListView(
          children: List.generate(pageSortList.length, (index) {
            return SwitchListTile(
              key: UniqueKey(),
              title: Text(
                  '${alldata['pages'][pageSortList[index].toString()]['name']}'),
              value: pageSwitchEnable.contains(pageSortList[index]),
              onChanged: (value) {
                if (!value) {
                  pageSwitchEnable.remove(pageSortList[index]);
                  final int newInt = pageSortList.removeAt(index);
                  pageSortList.insert(pageSortList.length, newInt);

                  setState(() {
                    pageSwitchEnable = pageSwitchEnable;
                  });
                } else {
                  pageSwitchEnable.insert(0, pageSortList[index]);
                  final int newInt = pageSortList.removeAt(index);
                  pageSortList.insert(0, newInt);

                  setState(() {
                    pageSwitchEnable = pageSwitchEnable;
                  });
                }
                //  print(pageSwitchEnable.contains(pageSortList[index]));
                //  print(pageSortList);
                print(pageSwitchEnable);
              },
            );
          }),
          onReorder: (int oldIndex, int newIndex) async {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }

              if (pageSwitchEnable.contains(pageSortList[oldIndex])) {
              } else {
                final int newInt = pageSortList.removeAt(oldIndex);
                pageSortList.insert(newIndex, newInt);
                pageSwitchEnable.removeAt(oldIndex);
                pageSwitchEnable.insert(newIndex, newInt);
              }
              print(pageSwitchEnable);
            });

            alldata['pageslist'] = pageSwitchEnable;
            String alldataString = jsonEncode(alldata);
            FileIO().writeData(alldataString);
            var formData = FormData.fromMap({
              'file': MultipartFile.fromString(alldataString,
                  filename: 'alldata.json')
            });
            var dio = Dio();

            var response = new Response(); //Response from Dio
            response = await dio.put("http://bbclock.lan", data: formData);

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
          }),
    );
  }
}
