import 'package:flutter/material.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/message/notice_model.dart';

// ignore: must_be_immutable
class NoticeCard extends StatefulWidget {
  final NoticeTypeModel model;

  /// 选中代码
  final int? selectIndex;

  /// tap 事件
  final Function(int typeId)? onTap;
  NoticeCard(
      {super.key, required this.model, this.onTap, required this.selectIndex});

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.selectIndex == widget.model.id
            ? Color(0xFF171A26)
            : Color(0xFF222633),
        borderRadius: BorderRadius.circular(20.0),
        border: widget.selectIndex == widget.model.id
            ? Border.all(
                color: const Color(0xFF3D35C6),
                width: 1.0,
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        widget.model.name,
        style: TextStyle(
          color: widget.selectIndex == widget.model.id
              ? Colors.white
              : const Color(0xFF707A8C),
          fontSize: 13,
        ),
      ),
    ).onTap(() => widget.onTap?.call(widget.model.id));
  }
}
