import 'package:flutter/widgets.dart';

class ResetTimerNotification extends Notification {
  final Duration newDelay;

  ResetTimerNotification(this.newDelay);
}