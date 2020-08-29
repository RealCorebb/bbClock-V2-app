import 'dart:async';
import 'dart:convert';

import 'dart:convert' as convert;
import 'package:bbClock/screens/details/components/page_settings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/screens/setting/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_io/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'components/search_box.dart';
import 'models/fileIO.dart';

var wschannel ;
final streamController = StreamController.broadcast();
String bbclockURL = "bbclock.lan";
bool wsbool = false;

int page = 0;
Map<String, dynamic> alldata;
Map<String, dynamic> alldata_temp;
void main() {
  runApp(bbClock());
}


class bbClock extends StatefulWidget {
  @override
  _bbClockState createState() => _bbClockState();
}
class _bbClockState extends State<bbClock> {
  FileIO file = new FileIO();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    file.readData();
  }
  @override
  Widget build(BuildContext context) {
    
    
    
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
