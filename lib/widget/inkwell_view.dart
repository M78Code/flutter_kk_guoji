import 'package:flutter/material.dart';

///自定义水波紋点击按钮
class InkWellView extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final BorderRadius borderRadius;
  final Color splashColor;
  final Color highlightColor;
  final Color backColor = Colors.transparent;
  final double? width, height, borderWidth;
  final LinearGradient? gradient;
  final Color borderColor;

  const InkWellView({
    super.key,
    required this.child,
    this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.splashColor = const Color(0xffFEFEFE),
    this.highlightColor = const Color(0xffFEFEFE),
    this.borderColor = Colors.transparent,
    this.borderWidth,
    this.width,
    this.height,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth ?? 1),
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          child,
          Material(
            type: MaterialType.transparency,
            borderRadius: borderRadius,
            child: Ink(
              height: width,
              width: width,
              color: backColor,
              child: InkWell(
                splashColor: splashColor.withOpacity(0.1),
                highlightColor: Colors.transparent,
                borderRadius: borderRadius,
                onTap: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
