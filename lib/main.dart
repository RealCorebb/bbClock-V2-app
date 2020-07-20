import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bbClock/constants.dart';
import 'package:bbClock/screens/setting/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/io.dart';
import 'components/search_box.dart';

void main() {
  runApp(bbClock());
}

class bbClock extends StatelessWidget {
  final wschannel = IOWebSocketChannel.connect('ws://192.168.2.119/ws');
  @override
  Widget build(BuildContext context) {
    wschannel.stream.listen(
      (dynamic message) {},
      onDone: () {
        debugPrint('ws channel closed');
      },
      onError: (error) {
        debugPrint('ws error $error');
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
