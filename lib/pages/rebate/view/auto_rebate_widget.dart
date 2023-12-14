import 'package:flutter/material.dart';

class KKAutoRebateWidget extends StatelessWidget {
  const KKAutoRebateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0x1F6A6CB2),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 26,
          child:  const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width:70,
                  child: Center(
                    child: Text("游戏类型", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  )
              ),
              SizedBox(
                  width:70,
                  child: Center(
                    child: Text("总大码量", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  )
              ),
              SizedBox(
                  width:70,
                  child: Center(
                    child: Text("返水比例", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  )
              ),
              SizedBox(
                  width:70,
                  child: Center(
                    child: Text("金额", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  )
              ),


            ],
          ),
        ),
        MediaQuery.removePadding(context: context, removeTop: true, child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return  Container(
              height: 37,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 70, child: Center(
                    child: Text("100348", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),),
                  SizedBox(width: 70, child: Center(
                    child: Text("100348", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),),
                  SizedBox(width: 70, child: Center(
                    child: Text("100346", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),),
                  SizedBox(width: 70, child: Center(
                    child: Text("100346", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),),                    ],
              ),
            );
          }, itemCount: 10,)),
      ],
    );
  }
}
