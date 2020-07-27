import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/screens/setting/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/io.dart';
import 'components/search_box.dart';
import 'models/fileIO.dart';

bool wsbool = false;
Map<String, dynamic> alldata;
void main() {
  runApp(bbClock());
}

class bbClock extends StatelessWidget {
  static var wschannel = IOWebSocketChannel.connect('ws://bbclock.lan/ws');
  FileIO file = new FileIO();

  @override
  Widget build(BuildContext context) {
    Future<String> jsonString = file.readData();
    print(jsonString);
    wschannel.stream.listen(
      (dynamic message) async {
        if (message == "iambbclock") {
          debugPrint('connected');
          wsbool = true;
          wsstatus.text = "已连接";
          var response = await http.get("http://bbclock.lan/alldata.json");
          if (response.statusCode == 200) {
            String jsonString = utf8.decode(response.bodyBytes);
            file.writeData(jsonString);
            alldata = jsonDecode(jsonString);
            print("write done");
            print('${alldata['pageslist']}');
          }
        }
      },
      onDone: () {
        debugPrint('ws channel closed');
        wsbool = false;
        wsstatus.text = "正在尝试连接";
        wschannel = IOWebSocketChannel.connect('ws://bbclock.lan/ws');
      },
      onError: (error) {
        debugPrint('ws error $error');
        wschannel = IOWebSocketChannel.connect('ws://bbclock.lan/ws');
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bbClock-V2',
      theme: ThemeData(
        // We set Poppins as our default font
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
