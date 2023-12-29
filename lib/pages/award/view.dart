import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';

import '../../widget/custome_app_bar.dart';
import 'logic.dart';

class AwardPage extends StatefulWidget {
  AwardPage({Key? key}) : super(key: key);

  final logic = Get.find<AwardLogic>();

  @override
  State<StatefulWidget> createState() => crateAwardState ();


}


class crateAwardState extends State<AwardPage> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const KKCustomAppBar("福利奖励"),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///领取奖金总和
              _buildClaimBonus(),
              _buildTotalReward(),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(color: Color(0xFF0D1518)),
              ),
              SizedBox(height: 15,),
              _buildTab(),
              _buildAwardList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwardList(){
    return Container(

    );
  }

  Widget _buildTab(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = 1;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: selectedValue == 1 ? Color(0xFF0D1518) : Color(0xFF222633),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color:selectedValue==1? Color(0xFF3D35C6):Color(0xFF222633)),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text('全部奖励',style: TextStyle(fontSize: 13,color: selectedValue==1?Colors.white:Color(0xFF70798B)),),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = 2;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: selectedValue == 2 ? Color(0xFF0D1518) : Color(0xFF222633),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color:selectedValue==2? Color(0xFF3D35C6):Color(0xFF222633)),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text('任务奖励',style: TextStyle(fontSize: 13,color: selectedValue==2?Colors.white:Color(0xFF70798B)),),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = 3;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: selectedValue == 3 ? Color(0xFF0D1518) : Color(0xFF222633),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color:selectedValue==3? Color(0xFF3D35C6):Color(0xFF222633)),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text('一般奖励',style: TextStyle(fontSize: 13,color: selectedValue==3?Colors.white:Color(0xFF70798B)),),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = 4;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: selectedValue == 4 ? Color(0xFF0D1518) : Color(0xFF222633),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color:selectedValue==4? Color(0xFF3D35C6):Color(0xFF222633)),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text('贵宾奖励',style: TextStyle(fontSize: 13,color: selectedValue==4?Colors.white:Color(0xFF70798B)),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalReward(){
    return Container(
      height: 84,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTotalRewardItem('任务奖励总额','0.00'),
          _buildTotalRewardItem('一般奖励总额','0.00'),
          _buildTotalRewardItem('贵宾奖励总额','0.00'),
        ],
      ),
    );
  }

  Widget _buildTotalRewardItem(String name,String amount){
    return Container(
      width: 115,
      height: 63,
      decoration: ShapeDecoration(
        color: Color(0x1E6A6CB2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'PingFang SC',
              ),
            ),
            SizedBox(height: 4,),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '¥',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                  ),
                ),
                Text(
                  amount,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'DIN',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimBonus (){
    return Container(
      height: 74,
      margin: EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF2E374C), Color(0xFF181E2F)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 14,),
          Image.asset('assets/images/mine/icon_ylq.png',width: 44,height: 44,),
          SizedBox(width: 14,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '已领取奖金总额',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              SizedBox(height: 4,),
              Text(
                '¥88,686.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'DIN',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              )
            ],
          ),
          Expanded(child: SizedBox()),
          Container(
            width: 100,
            height: 39,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFF2D374E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                '领取记录',
                style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'PingFang SC',),
              ),
            ),
          ),
          SizedBox(width: 18,)
        ],
      ),
    );
  }
}

