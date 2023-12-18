import 'package:flutter/material.dart';

class KKProgressbar extends StatelessWidget {
  final double width;
  final double height;
  final Axis? direction;
  final double value;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? outerDecoration;
  final BoxDecoration? innerDecoration;

  const KKProgressbar({
    Key? key,
    required this.value,
    required this.width,
    required this.height,
    this.direction,
    this.padding,
    this.margin,
    this.outerDecoration,
    this.innerDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVertical = (direction ?? Axis.horizontal) == Axis.vertical;
    final fnPadding = padding ?? EdgeInsets.zero;
    return Container(
      height: height,
      width: width,
      decoration: outerDecoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black12,
          ),
      padding: fnPadding,
      margin: margin,
      alignment: isVertical ? Alignment.bottomCenter : Alignment.centerLeft,
      child: Container(
        width: isVertical ? null : value * (width - fnPadding.left - fnPadding.right),
        height: isVertical ? value * (height - fnPadding.top - fnPadding.bottom) : null,
        decoration: innerDecoration ?? const BoxDecoration(),
      ),
    );
  }
}