import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/claimrecord/claim_record.logic.dart';

import '../../activity/list/widgets/item_widget.dart';

class ClaimRecordPage extends GetView<ClaimRecordLogic> {
  const ClaimRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ClaimRecordLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '领取记录',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
            padding: const EdgeInsets.all(16),
            iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_normal.png')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      //在AppBar下方添加一条白色线
                      color: Color.fromRGBO(255, 255, 255, 0.06),
                      width: 1))),
        ),
        actions: const [
          Text(
            '88888888   ',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      body: _buildView(),
    );
  }

  Column _buildView() {
    return Column(
      children: [
        _buildSelectionView(),
        const SizedBox(height: 10),
        _displayDaysView(),
        const SizedBox(height: 15),
        _contentTopView(),
        Expanded(child: _contentListView()),
      ],
    );
  }

  Widget _buildSelectionView() {
    return GetBuilder<ClaimRecordLogic>(
      id: "categoryView",
      builder: (controller) {
        return Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.messageSelectBar.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: controller.selectBar[index],
                isSelected:
                    // ignore: unrelated_type_equality_checks
                    controller.selectedCategoryId ==
                        controller.selectBar[index].index,
                onTap: (type) {
                  controller.onCategoryTap(type);
                  type = index + 1;
                },
              ).paddingOnly(right: 10);
            },
          ),
        ).paddingSymmetric(horizontal: 12.w, vertical: 12.w);
      },
    );
  }

  //显示天数
  Widget _displayDaysView() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 13),
        Text('*', style: TextStyle(color: Color(0xFFFF8900))),
        SizedBox(width: 2),
        Text(
          '仅显示30天的交易',
          style: TextStyle(
              color: Color(0xFF686F83),
              fontSize: 12,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget _contentTopView() {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13),
      height: 30,
      decoration: const BoxDecoration(color: Color(0x1E6A6CB2)),
      child: const Stack(
        children: [
          Positioned(
              left: 20,
              top: 6,
              child: SizedBox(
                width: 105,
                child: Text(
                  '时间',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xFFB2B3BD),
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              child: Text(
                '任务类型',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFB2B3BD),
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Positioned(
              right: 10,
              top: 6,
              child: SizedBox(
                width: 105,
                child: Text(
                  '领取金额',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xFFB2B3BD),
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              )),
        ],
      ),
    );
  }

  Widget _contentListView() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  '2023-11-18 10:04:23',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )),
                Expanded(
                    child: Text(
                  '贵宾奖励',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  '10.00',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xFF13CF3D),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ))
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 10,
            endIndent: 10,
          );
        },
      ),
    );
  }
}
