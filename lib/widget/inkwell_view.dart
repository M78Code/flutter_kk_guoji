import 'package:flutter/material.dart';

///自定义水波紋点击按钮
class InkWellView extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double borderRadius;
  final Color splashColor;
  final Color highlightColor;
  final Color? backColor;
  final double? width, height, borderWidth;
  final Gradient? gradient;
  final Color borderColor;
  final BoxDecoration? boxDecoration;

  const InkWellView({
    super.key,
    required this.child,
    this.onPressed,
    this.borderRadius = 4,
    this.splashColor = const Color(0xffFEFEFE),
    this.highlightColor = const Color(0xffFEFEFE),
    this.borderColor = Colors.transparent,
    this.borderWidth,
    this.width,
    this.height,
    this.gradient,
    this.backColor,
    this.boxDecoration,
  });

//image: DecorationImage(image: AssetImage(bgImage)),
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: boxDecoration ??
          BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth ?? 1),
            gradient: gradient,
            color: backColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // child,
          Center(child: child),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Ink(
                height: width,
                width: width,
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColor.withOpacity(0.1),
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
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
