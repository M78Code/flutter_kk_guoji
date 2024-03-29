import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/mine_logic.dart';
import 'package:kkguoji/pages/mine/mine_page.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../services/cache_key.dart';

enum SocketStatus {
  socketStatusConnected,
  socketStatusFailed,
  socketStatusClosed,
}

typedef ListenMessageCallback = void Function(Map msg);
typedef ListenNoticeCallback = void Function(dynamic);

class WebSocketUtil {
  factory WebSocketUtil() => _getInstance();

  static WebSocketUtil get instance => _getInstance();

  static WebSocketUtil? _instance;

  WebSocketChannel? _webSocket;
  SocketStatus _socketStatus = SocketStatus.socketStatusClosed;
  ListenMessageCallback? _ticketMsgCallback;
  ListenNoticeCallback? _noticeMsgCallback;

  get socketStatus => _socketStatus;
  final sqliteService = Get.find<SqliteService>();

  WebSocketUtil._initial() {}

  void connetSocket() {
    if (_webSocket != null) {
      closeSocket();
    }
    String connectUrl = "ws://18.167.51.38:9502/web";
    if (sqliteService.getString(CacheKey.apiToken) != null) {
      connectUrl += "?token=Bearer%20${sqliteService.getString(CacheKey.apiToken)!}";
    }
    _webSocket = IOWebSocketChannel.connect(connectUrl, pingInterval: const Duration(seconds: 10));
    _socketStatus = SocketStatus.socketStatusConnected;
    _webSocket?.stream.listen((event) {
      _webSocketReciveMessage(event);
    }, onError: _webSocketConnetedError);
  }

  void _webSocketReciveMessage(event) {
    print("event====$event");
    if (event == "Opened") {
      _sendMessage();
      return;
    }
    Map msgInfo = json.decode(event);
    if (msgInfo["event"] == "update_lottery_draw_time") {
      if (_ticketMsgCallback != null) {
        Map value = msgInfo["data"] as Map;
        _ticketMsgCallback!(value);
        // _ticketMsgCallback!(value.values.first);
      }
    } else if (msgInfo["event"] == "other_places_login") {
      Get.find<UserService>().logout();
      Get.defaultDialog(
          titlePadding: EdgeInsets.zero,
          title: "",
          backgroundColor: const Color(0xFF171A26),
          content: Container(
            alignment: Alignment.center,
            child: const Text(
              "你的账户在其他地方登录。如非本人操作,请立即修改密码",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          cancel: Container(
            width: 100,
            height: 40,
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
              child: const Text(
                "确认",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ));
    } else if (msgInfo["event"] == "get_big_win_recent") {
      if (_noticeMsgCallback != null) {
        _noticeMsgCallback!(msgInfo);
      }
    } else if (msgInfo["event"] == "get_system_notice") {
      if (_noticeMsgCallback != null) {
        int value = msgInfo["data"];
        _noticeMsgCallback!(value);
      }
    }
  }

  void _sendMessage() {
    List list = [
      {"event": "get_game_bet_recent"},
      {"event": "get_hks_recent"},
      {"event": "get_win_recent"},
      {"event": "get_big_win_recent"},
      {"event": "get_user_message"},
      // {"event":"get_system_notice"},
      // {"event":"update_agent_rules"},
    ];
    list.forEach((element) {
      _webSocket?.sink.add(jsonEncode(element));
    });
  }

  void _webSocketConnetedError(e) {
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

  void listenNoticeMessage(ListenNoticeCallback tickMsgCallback) {
    _noticeMsgCallback = tickMsgCallback;
  }

  void closeSocket() {
    _webSocket?.sink.close();
    _socketStatus = SocketStatus.socketStatusClosed;
    _webSocket = null;
  }

  void reconnectSocket() {
    connetSocket();
  }
}
