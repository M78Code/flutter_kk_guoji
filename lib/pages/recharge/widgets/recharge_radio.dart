import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RechargeRadio extends StatefulWidget {
  final String? imgPath;
  final String activePath;
  final String defaultPath;
  bool isSelected;
  final double width;
  final double height;
  VoidCallback? callMe;
  final ImageRadioController controller;
  final ValueChanged<bool> onChange;

  RechargeRadio({
    super.key,
    this.imgPath,
    required this.activePath,
    required this.defaultPath,
    this.width = 98,
    this.height = 39,
    required this.controller,
    required this.onChange,
    this.isSelected = false,
  });

  @override
  State<RechargeRadio> createState() => _RechargeRadioState();
}

class _RechargeRadioState extends State<RechargeRadio> {
  VoidCallback? makeMeUnselect;

  @override
  void initState() {
    makeMeUnselect = () {
      setState(() {
        widget.isSelected = false;
      });
      widget.onChange(false);
    };

    //backup
    widget.callMe = makeMeUnselect!;
    widget.controller.add(makeMeUnselect!);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.remove(makeMeUnselect!);
    super.dispose();
  }

  @override
  void didUpdateWidget(RechargeRadio oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget != widget && oldWidget.callMe != makeMeUnselect) {
      widget.controller.remove(oldWidget.callMe!);
      widget.controller.add(makeMeUnselect!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = true;
        });
        widget.onChange(true);

        widget.controller.unselectOthers(makeMeUnselect!);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //       width: widget.isSelected
        //           ? widget.activeBorderWidth
        //           : widget.inactiveBorderWidth,
        //       color: widget.isSelected
        //           ? widget.activeBorderColor
        //           : widget.inactiveBorderColor),
        //   borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        // ),
        child: Image.asset(
          widget.isSelected ? widget.activePath : widget.defaultPath,
          // fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}


class ImageRadioController {
  List<VoidCallback>? _callbackList;

  ImageRadioController() {
    _callbackList = [];
  }

  void add(VoidCallback callback) {
    _callbackList?.add(callback);
  }

  void remove(VoidCallback callback) {
    _callbackList?.remove(callback);
  }

  void dispose() {
    _callbackList?.clear();
    _callbackList = null;
  }

  void unselectOthers(VoidCallback currentCallback) {
    if (null != _callbackList && _callbackList!.isNotEmpty) {
      for (int i = 0; i < _callbackList!.length; i++) {
        VoidCallback callback = _callbackList![i];
        if (callback == currentCallback) continue;
        callback();
      }
    }
  }
}
