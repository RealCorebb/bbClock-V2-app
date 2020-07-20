import 'package:bbClock/models/websocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bbClock/constants.dart';
import 'package:web_socket_channel/io.dart';

import 'components/body.dart';

class MainScreen extends StatelessWidget {
  static WebSocketsNotifications wschannel = new WebSocketsNotifications();
  static final channel = IOWebSocketChannel.connect('ws://bbclock.lan/ws');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('控制台'),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
