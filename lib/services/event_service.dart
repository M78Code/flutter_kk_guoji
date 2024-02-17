abstract class EventListener {
  void onEvent(String eventId, dynamic event);
}

class EventService {


  EventService._();
  static EventService? _instance;
  static EventService _getInstance() {
    _instance ??= EventService._();
    return _instance!;
  }
  static EventService get instance => _getInstance();
  factory EventService() => _getInstance();

  final listeners = <String, List<EventListener>>{};

  void addListener(String eventId, EventListener listener) {
    if (listeners.containsKey(eventId)) {
      listeners[eventId]!.add(listener);
    } else {
      listeners[eventId] = [listener];
    }
  }

  void removeListener(String? eventId, EventListener listener) {
    if (eventId == null) {
      listeners.forEach((key, value) {
        value.remove(listener);
      });
    } else {
      listeners[eventId]?.remove(listener);
    }
  }

  void dispatchEvent(String eventId, [dynamic data]) {
    if (listeners.containsKey(eventId)) {
      for (var element in listeners[eventId]!) {
        element.onEvent(eventId, data);
      }
    }
  }

}