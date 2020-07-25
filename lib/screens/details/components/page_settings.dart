import 'package:bbClock/main.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);
var channel = bbClock.wschannel;
// ValueChanged<Color> callback
void changeColor(Color color) {
  print(color.toString().split('(0xff')[1].split(')')[0]);
  channel.sink.add("c" + color.toString().split('(0xff')[1].split(')')[0]);
}

class PagesSettingsWidget extends StatefulWidget {
  @override
  _PagesSettingsState createState() => _PagesSettingsState();
}

class _PagesSettingsState extends State<PagesSettingsWidget> {
  @override
  Widget build(BuildContext context) {
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
                      width: 1280,
                      height: 320,
                      child: Row(
                        children: <Widget>[
                          //RaisedButton(),
                          Container(
                              //padding: EdgeInsets.only(top: 10),
                              width: 78,
                              //color: Colors.green,
                              child: Image(
                                  filterQuality: FilterQuality.none,
                                  image: NetworkImage(
                                      "http://bbclock.lan/gifs/1.gif"),
                                  fit: BoxFit.fitWidth)),
                          InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  titlePadding: const EdgeInsets.all(0.0),
                                  contentPadding: const EdgeInsets.all(0.0),
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
                                'Page1',
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 48),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
