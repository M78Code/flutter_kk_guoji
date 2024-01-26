import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';

import '../../../../../generated/assets.dart';

final GlobalKey dateSelectionSectionKey = GlobalKey();

class DateSelectionSection extends StatelessWidget {
  static var kHeight = 42.w;
  final void Function(String dataType) onTap;
  final void Function() onTapSelectTime;
  final List<List<String>> dateTypes;
  final String selectType;
  final String? selectDateRange;

  DateSelectionSection({required this.onTap,required this.dateTypes, required this.selectType, required this.onTapSelectTime, this.selectDateRange});

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Container(
      key: dateSelectionSectionKey,
      height: 42.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(width: 10.w,),
          Expanded(
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
                      selectDateRange ?? '选择时间段',
                      style: TextStyle(color: selectDateRange == null ? Color(0xA8FFFFFF) : Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ).marginOnly(left: 10.w),
                    Image.asset(
                        Assets.mineWalletSearch,
                        width: 29.w,
                        height: 29.w)
                        .marginOnly(right: 12.w),
                  ]),
            ).onTap(() {
              this.onTapSelectTime.call();
            }),
          ),
        ],
      ),
    );
  }

  Widget buildDateItem(List<String> datas) {
    bool isSelected = selectType == datas.first;
    return InkWell(
      onTap: () {
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