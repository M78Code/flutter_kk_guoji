import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
class DateSelectionSection extends StatefulWidget {
  @override
  _DateSelectionSectionState createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State<DateSelectionSection> {
  int selectedDateIndex = 0; // Keep track of selected date index

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.w,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.w),
              color: Color(0xFF222633),
            ),
            padding: EdgeInsets.all(6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildDateItem(0, '今天'),
                buildDateItem(1, '昨天'),
                buildDateItem(2, '本月'),
                buildDateItem(3, '上月'),
              ],
            ),
          ),
          SizedBox(width: 20.w,),
          SizedBox(
            child: Container(
              height: 42.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                color: Color(0xFF222633),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '选择时间段',
                      style: TextStyle(color: Color(0x33FFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ).marginOnly(left: 20.w),
                    Image.asset(
                        Assets.mineWalletSearch,
                        width: 29.w,
                        height: 29.w)
                        .marginOnly(right: 12.w),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDateItem(int index, String text) {
    return InkWell(
      onTap: () {
        // Handle date selection
        setState(() {
          selectedDateIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.w),
          border: selectedDateIndex == index ? Border.all(
            color: const Color(0xB54E5AC5),
            width: 1.0,
          ) : null,
          gradient: selectedDateIndex == index ? const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]):null,
        ),
        padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
        child: Text(
          text,
          style: TextStyle(
            color: selectedDateIndex == index ? Colors.white : Colors.grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}