import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

WebSocketsNotifications sockets = new WebSocketsNotifications();

const String _SERVER_ADDRESS = 'ws://bbclock.lan/ws';

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets =
      new WebSocketsNotifications._internal();

  factory WebSocketsNotifications() {
    return _sockets;
  }

  WebSocketsNotifications._internal();

  ///
  ///  channel
  ///
  IOWebSocketChannel _channel;

  ///
  /// 长连接是否建立
  ///
  bool _isOn = false;

  ///
  /// Listeners
  /// 监听事件对应处理函数
  ///
  ObserverList<Function> _listeners = new ObserverList<Function>();

  ///
  /// 初始化长连接
  ///
  initCommunication() async {
    reset();

    ///
    /// 开启长连接
    ///
    try {
      print('==socket== connect sockets ip: $_SERVER_ADDRESS');
      _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS);

      ///
      /// Start listening to new messages
      ///
      _isOn = true;
      _channel.stream.listen(_handleMassageFromServer);
    } catch (e) {
      ///
      /// error handle
      ///
    }
  }

  ///
  /// 关闭长连接
  ///
  reset() {
    if (_channel != null) {
      if (_channel.sink != null) {
        print('==socket== close sockets');
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  ///
  /// 给服务器发消息
  ///
  send(message) {
    if (_channel != null) {
      if (_channel.sink != null && _isOn) {
        print('==socket== message to server:' + message);
        _channel.sink.add(message);
      }
    }
  }

  ///
  /// 添加回调
  ///
  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }

  ///
  /// 收到服务端时的Callback
  ///
  _handleMassageFromServer(message) {
    print('==socket== message from server:' + message);
    _listeners.forEach((Function callback) {
      callback(message);
    });
  }
}
