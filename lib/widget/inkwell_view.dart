import 'package:flutter/material.dart';

///自定义水波紋点击按钮
class InkWellView extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final BorderRadius borderRadius;
  final Color splashColor;
  final Color highlightColor;
  final Color backColor = Colors.transparent;
  final double? width, height;

  const InkWellView({
    super.key,
    required this.child,
    this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.splashColor = const Color(0xffFEFEFE),
    this.highlightColor = const Color(0xffFEFEFE),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              borderRadius: borderRadius,
              child: Ink(
                color: backColor,
                child: InkWell(
                  splashColor: splashColor.withAlpha(200),
                  highlightColor: Colors.transparent,
                  borderRadius: borderRadius,
                  onTap: onPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
