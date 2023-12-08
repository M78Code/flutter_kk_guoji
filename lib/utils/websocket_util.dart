
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum SocketStatus {
  socketStatusConnected,
  socketStatusFailed,
  socketStatusClosed,
}


typedef ListenMessageCallback = void Function(Map msg);

class WebSocketUtil {
  factory WebSocketUtil() => _getInstance();

  static WebSocketUtil get instance => _getInstance();

  static WebSocketUtil? _instance;
  String connectUrl = "ws://18.167.51.38:9502/web";

  late WebSocketChannel _webSocket;
  SocketStatus _socketStatus = SocketStatus.socketStatusClosed;
  ListenMessageCallback? _ticketMsgCallback;

  get socketStatus => _socketStatus;

  WebSocketUtil._initial() {}

  void connetSocket() {
    _webSocket = IOWebSocketChannel.connect(connectUrl, pingInterval: const Duration(seconds: 5));
    _socketStatus = SocketStatus.socketStatusConnected;
    _webSocket.stream.listen((event) {
        _webSocketReciveMessage(event);
    }, onError: _webSocketConnetedError);
  }


  void _webSocketReciveMessage(event) {
     print("event====$event");
     if(event == "Opened") {
       return;
     }
     Map msgInfo = json.decode(event);
     if(msgInfo["event"] == "update_lottery_draw_time") {
       if(_ticketMsgCallback != null) {
         Map value = msgInfo["data"] as Map;
         _ticketMsgCallback!(value);
         // _ticketMsgCallback!(value.values.first);
       }
     }

  }

  void _webSocketConnetedError( e ) {
    print(e);
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.socketStatusFailed;
  }

  static WebSocketUtil _getInstance() {
    _instance ??= WebSocketUtil._initial();
    return _instance!;
  }

  void listenTicketMessage(ListenMessageCallback tickMsgCallback) {
      _ticketMsgCallback = tickMsgCallback;
  }

  void closeSocket() {
    _webSocket.sink.close();
    _socketStatus = SocketStatus.socketStatusClosed;
  }


  void reconnectSocket() {
    connetSocket();
  }

}