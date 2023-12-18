
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/mine_logic.dart';
import 'package:kkguoji/pages/mine/mine_page.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../services/cache_key.dart';

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
  final sqliteService = Get.find<SqliteService>();

  WebSocketUtil._initial() {}

  void connetSocket() {
    Map<String, dynamic> headers = {};
    if(sqliteService.getString(CacheKey.apiToken) != null) {
      connectUrl += "?token=Bearer%20${sqliteService.getString(CacheKey.apiToken)!}";
    }
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
     }else if (msgInfo["event"] == "other_places_login") {
       Get.find<MineLogic>().clickLogout();
       Get.defaultDialog(
           titlePadding: EdgeInsets.zero,
           backgroundColor: const Color(0xFF171A26),
           content: Container(
             alignment: Alignment.center,
             child: const Text("你的账户在其他地方登录。如非本人操作,请立即修改密码",
               style: TextStyle(color: Colors.white, fontSize: 16,),
               textAlign: TextAlign.center,),
           ),
           cancel: Container(
             width:100,
             height:40,
             margin: const EdgeInsets.symmetric(vertical: 10),
             decoration: BoxDecoration(
               gradient: const LinearGradient(
                 colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
               ),
               borderRadius: BorderRadius.circular(20),
             ),

             child: TextButton(
               onPressed: () {
                 Get.back();
               },
               child: const Text("确认", style: TextStyle(color: Colors.white, fontSize: 15),),
             ),
           )
       );
     }

  }

  _showNormalSimpleDialog(BuildContext context) async {
    int result = await showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(10), // 内容外间距
          // 子控件，可以随意自定义
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: const Text("你的账户在其他地方登录。如非本人操作,请立即修改密码", style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text("确认", style: TextStyle(color: Colors.white, fontSize: 15),),
            ),
          ],
        );
      },
    );
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