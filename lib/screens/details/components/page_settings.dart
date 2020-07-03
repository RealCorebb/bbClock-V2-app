import 'package:bbClock/screens/setting/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/models/settings.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'list_of_colors.dart';
Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);
var channel = MainScreen.channel;
// ValueChanged<Color> callback
void changeColor(Color color) {
  print(color.toString().split('(0xff')[1].split(')')[0]);
  channel.sink.add("c"+color.toString().split('(0xff')[1].split(')')[0]);
}

class PagesSettings extends StatelessWidget {

  const PagesSettings({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
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
                Center(
                child: RaisedButton(
                  elevation: 3.0,
                  onPressed: () {
                    showDialog(
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
                    );
                  },
                  child: const Text('修改文字颜色'),
                  color: currentColor,
                  textColor: useWhiteForeground(currentColor)
                      ? const Color(0xffffffff)
                      : const Color(0xff000000),
                ),
              ),
                  ListOfColors(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      '页面设置',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
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
