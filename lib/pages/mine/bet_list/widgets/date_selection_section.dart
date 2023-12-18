import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';

class DateSelectionSection extends StatelessWidget {

  final void Function(String dataType) onTap;
  final List<List<String>> dateTypes;
  final String selectType;

  DateSelectionSection({required this.onTap,required this.dateTypes, required this.selectType});

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
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
              children: dateTypes.map((e) {
                return buildDateItem(e);
              }).toList(),
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

  Widget buildDateItem(List<String> datas) {
    bool isSelected = selectType == datas.first;
    return InkWell(
      onTap: () {
        // controller.onTapSwitchFundDetailDate(datas.first);
        onTap.call(datas.first);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.w),
          border: isSelected ? Border.all(
            color: const Color(0xB54E5AC5),
            width: 1.0,
          ) : null,
          gradient: isSelected ? const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]):null,
        ),
        padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
        child: Text(
          datas[1],
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}