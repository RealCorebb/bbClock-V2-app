import 'dart:async';

import 'package:bbClock/main.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
void changeColor(Color color) {
  print(color.toString().split('(0xff')[1].split(')')[0]);
  wschannel.sink.add("c" + color.toString().split('(0xff')[1].split(')')[0]);
}

class PagesSettingsWidget extends StatefulWidget {
  @override
  _PagesSettingsState createState() => _PagesSettingsState();
}

class _PagesSettingsState extends State<PagesSettingsWidget> {
  final controller = PageController(initialPage: page);
  List<dynamic> allpages = alldata["pageslist"];
  @override
  @override
  Widget build(BuildContext context) {
    streamController.stream.listen(
      (dynamic message) async {
        page = int.parse(message);
        controller.animateToPage(page,
            duration: Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
    return SafeArea(
      bottom: false,
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
                                          child: MaterialPicker(
                                            pickerColor: currentColor,
                                            onColorChanged: changeColor,
                                            enableLabel: true,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  child: Container(
                                    child: Text(
                                      ' ${alldata['pages'][int.parse('${alldata['pageslist'][i]}')]['text'][0]}',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 96,
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
                          wschannel.sink.add("f");
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
                          wschannel.sink.add("p");
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
                          wschannel.sink.add("n");
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
}
