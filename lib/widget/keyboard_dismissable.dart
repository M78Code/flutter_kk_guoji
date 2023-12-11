import 'package:flutter/material.dart';

/// 用于点击空白处退出软键盘
class KeyboardDissmissable extends StatelessWidget {
  final Widget? child;

  const KeyboardDissmissable({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
