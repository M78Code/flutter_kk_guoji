import 'dart:async';

class EventBus {
  // 使用单例模式创建全局事件总线实例
  factory EventBus() => _singleton;

  EventBus._internal();

  static final EventBus _singleton = EventBus._internal();

  // 创建一个广播流控制器
  final _streamController = StreamController.broadcast();

  // 获取事件流（Stream）
  Stream get stream => _streamController.stream;

  // 发送事件
  void sendEvent(dynamic event) {
    _streamController.sink.add(event);
  }

  // 关闭流
  void dispose() {
    _streamController.close();
  }

}