import 'dart:async';
import 'dart:convert';
import 'package:bbClock/components/search_box.dart';
import 'package:bbClock/screens/details/components/advanced_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_io/io.dart';
import 'package:bbClock/main.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class FileIO {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/alldata.json');
  }
  Future<void> startWS() async{
    if(isAP) bbclockURL="192.168.4.1";
    wschannel = WebSocketChannel.connect(Uri.parse('ws://$bbclockURL/ws'));
    streamController.addStream(wschannel.stream);
    
    
    streamController.stream.listen(
      (dynamic message) async {
        if (message == "iambbclock") {
          debugPrint('connected');
          wsbool = true;
          wsstatus.text = "已连接";
          var response = await http.get("http://$bbclockURL/alldata.json");
          if (response.statusCode == 200) {
            String jsonString = utf8.decode(response.bodyBytes);
            //file.writeData(jsonString);
            alldata = jsonDecode(jsonString);
            print("write done");
            print('${alldata['pageslist']}');
          }
        } else if (message == "nextpage") {
        } else {
          page = int.parse(message);
          print(page.toString());
        }
      },
      onDone: () {
        debugPrint('ws channel closed');
        wsbool = false;
        wsstatus.text = "正在尝试连接设备";
        wschannel = WebSocketChannel.connect(Uri.parse('ws://$bbclockURL/ws'));
      },
      onError: (error) {
        debugPrint('ws error $error');
        wschannel = WebSocketChannel.connect(Uri.parse('ws://$bbclockURL/ws'));
      },
      
    );
  }
  Future<String> readData() async {
    try {
      final file = await localFile;

      // Read the file
      String contents = await file.readAsString();
      print("Hey!I read the Data!");
      print(contents);
      alldata = jsonDecode(contents);
      if (alldata['settings']['NetworkMode'] == "AP") isAP = true;
      print("【ISAP】");
      print(isAP);
      startWS();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      alldata = jsonDecode("{\"pages\":{\"0\":{\"name\":\"时间\",\"text\":[\"--:--:--\"],\"color\":\"FFFFFF\"},\"1\":{\"name\":\"今日天气\",\"text\":[\"Page1\"],\"color\":\"ffd74c\"},\"2\":{\"name\":\"今日天气\",\"text\":[\"Page2\"],\"color\":\"FFFF00\"},\"3\":{\"name\":\"今日天气\",\"text\":[\"Page3\"],\"color\":\"FFFFFF\"},\"4\":{\"name\":\"今日天气\",\"text\":[\"Page4\"],\"color\":\"FFFFFF\"},\"5\":{\"name\":\"今日天气\",\"text\":[\"Page5\"],\"color\":\"FFFFFF\"},\"6\":{\"name\":\"今日天气\",\"text\":[\"Page6\"],\"color\":\"FFFFFF\"},\"7\":{\"name\":\"湿度\",\"text\":[\"Page7\"],\"color\":\"FFFFFF\"},\"8\":{\"name\":\"空气质量\",\"text\":[\"AQI\"],\"color\":\"FFFFFF\"},\"9\":{\"name\":\"风速风向\",\"text\":[\"Page9\"],\"color\":\"FFFFFF\"},\"10\":{\"name\":\"今日最高温\",\"text\":[\"Page10\"],\"color\":\"ff7635\"},\"11\":{\"name\":\"今日最低温\",\"text\":[\"Page11\"],\"color\":\"FFFFFF\"},\"12\":{\"name\":\"日出时间\",\"text\":[\"Page12\"],\"color\":\"FFFFFF\"},\"13\":{\"name\":\"日落时间\",\"text\":[\"Page13\"],\"color\":\"FFFFFF\"},\"21\":{\"name\":\"次日天气\",\"text\":[\"天气\"],\"color\":\"FFFFFF\"},\"22\":{\"name\":\"次日天气\",\"text\":[\"天气\"],\"color\":\"FFFFFF\"},\"23\":{\"name\":\"次日天气\",\"text\":[\"天气\"],\"color\":\"FFFFFF\"},\"24\":{\"name\":\"次日天气\",\"text\":[\"天气\"],\"color\":\"FFFFFF\"},\"25\":{\"name\":\"次日天气\",\"text\":[\"天气\"],\"color\":\"FFFFFF\"},\"26\":{\"name\":\"次日天气\",\"text\":[\"天气\"],\"color\":\"FFFFFF\"},\"27\":{\"name\":\"次日湿度\",\"text\":[\"ID027\"],\"color\":\"FFFFFF\"},\"30\":{\"name\":\"次日最高温\",\"text\":[\"ID030\"],\"color\":\"FFFFFF\"},\"31\":{\"name\":\"次日最低温\",\"text\":[\"ID031\"],\"color\":\"FFFFFF\"},\"100\":{\"name\":\"Bilibili\",\"type\":\"social\",\"text\":[\"Bilibili\"],\"color\":\"FFFFFF\",\"url\":\"http://api.bilibili.com/x/relation/stat?vmid=\",\"jsonpath\":\"['data','follower']\",\"account\":\"bilibili\"},\"101\":{\"name\":\"微博\",\"type\":\"social\",\"text\":[\"Weibo\"],\"color\":\"FFFFFF\",\"url\":\"http://api.corebb.life/weibo?id=\",\"jsonpath\":\"['fans']\",\"account\":\"weibo\"},\"102\":{\"name\":\"Youtube\",\"type\":\"social\",\"text\":[\"YTube\"],\"color\":\"FFFFFF\",\"url\":\"http://api.corebb.life/youtube?id=\",\"jsonpath\":\"['subs']\",\"account\":\"youtube\"},\"103\":{\"name\":\"Instagram\",\"type\":\"social\",\"text\":[\"IG\"],\"color\":\"FFFFFF\",\"url\":\"http://api.corebb.life/instagram?id=\",\"jsonpath\":\"['subs']\",\"account\":\"instagram\"},\"104\":{\"name\":\"Github\",\"type\":\"social\",\"text\":[\"Github\"],\"color\":\"FFFFFF\",\"url\":\"http://api.corebb.life/github?id=\",\"jsonpath\":\"['subs']\",\"account\":\"github\"},\"105\":{\"name\":\"计数日\",\"text\":[\"天数\"],\"color\":\"f9b3ff\"},\"17\":{\"name\":\"日历\",\"text\":[\"01/01\",\"星期一\"],\"override_text\":\"1\",\"color\":\"ffe396\"}},\"accounts\":{\"bilibili\":\"xxx\",\"weibo\":\"xxx\",\"youtube\":\"xxx\",\"instagram\":\"xxx\",\"github\":\"xxx\",\"days\":\"1\"},\"settings\":{\"NetworkMode\":\"STA\",\"NetworkAddress\":\"http://bbClock.lan\",\"location\":\"Beijing\",\"time\":\"00:00:00\",\"textalign\":\"center\",\"autobrightness\":true,\"brightness\":50,\"volume\":50,\"autoNextPage\":true,\"isGestureOn\":true,\"autoInMusic\":true,\"interval\":10},\"pageslist\":[0,1,7,8,9,10,11,12,13,17,21,27,105,100,101,102],\"valid\":\"OK\"}");
      print("Read ERROR");
      startWS();
      return null;
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;

    // Write the file
    return file.writeAsString('$data');
  }

  uploadFile() async {
    final path = await localPath;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile('$path/alldata.json',
          filename: 'alldata.json')
    });
    var dio = Dio();

    var response = new Response(); //Response from Dio
    response = await dio.put("http://$bbclockURL", data: formData);
  }
}
