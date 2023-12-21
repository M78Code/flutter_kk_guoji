
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';

import '../../../../common/widgets/scroll_date_picker/src/scroll_date_picker.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({
    Key? key,
    required this.startDate,
    required this.endDate,
    this.dateConfirmAction,
    this.cancelAction,
  }) : super(key: key);

  final DateTime startDate;
  final DateTime endDate;
  void Function(DateTime startDate, DateTime endDate)? dateConfirmAction;
  void Function()? cancelAction;
  
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState(startDate: startDate, endDate: endDate, dateConfirmAction: dateConfirmAction, cancelAction: cancelAction);
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime startDate;
  late DateTime endDate;
  void Function(DateTime startDate, DateTime endDate)? dateConfirmAction;
  void Function()? cancelAction;

  _CustomDatePickerState({
    required DateTime startDate,
    required DateTime endDate,
    this.dateConfirmAction,
    this.cancelAction,
  })   : startDate = startDate,
        endDate = endDate;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildView();
  }

  Widget _buildView() {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 152.w,
        width: MediaQuery.of(context).size.width-24.w,
        margin: EdgeInsets.only(top: 10.w),
        padding:  EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Color(0xFF222633),
        ),
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "至",
                      style: TextStyle(color: Color(0xA8FFFFFF), fontWeight: FontWeight.w400, fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 80.w,
                      child: ScrollDatePicker(
                        selectedDate: startDate,
                        locale: Locale('zh'),
                        onDateTimeChanged: (DateTime value) {
                          setState(() {
                            startDate = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      "到",
                      style: TextStyle(color: Color(0xA8FFFFFF), fontWeight: FontWeight.w400, fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 80.w,
                      child: ScrollDatePicker(
                        selectedDate: endDate,
                          locale: Locale('zh'),
                        onDateTimeChanged: (DateTime value) {
                          setState(() {
                            endDate = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.06), height: 1,),
            SizedBox(height: 14.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientButton(
                  onPressed: () {
                    this.cancelAction?.call();
                  },
                  gradientColors: null,
                  text: "取消",
                ).expanded(),
                SizedBox(width: 10.w),
                GradientButton(
                  onPressed: () {
                    this.dateConfirmAction?.call(startDate, endDate);
                  },
                  gradientColors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
                  text: "确定",
                ).expanded(),
              ],
            ),
            SizedBox(height: 14.w),
          ],
        ),
      ),
    );
  }

}


class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final String text;

  const GradientButton({
    Key? key,
    required this.onPressed,
    this.gradientColors,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.w,
      decoration:  gradientColors == null ? BoxDecoration(
        color: Color(0xFF2E374E),
        borderRadius: BorderRadius.circular(6.0),
      ) : BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors ?? [],
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: gradientColors == null ? Color(0xFF707A8C) : Colors.white,
          ),
        ),
      ),
    );
  }
}