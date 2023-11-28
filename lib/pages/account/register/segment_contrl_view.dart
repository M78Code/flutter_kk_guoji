

import 'package:flutter/material.dart';

class SegmentControlView extends StatelessWidget {
  ValueChanged<int> changed;
  bool isAccount;
  SegmentControlView(this.changed, this.isAccount,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration:const BoxDecoration(
        color: Color.fromRGBO(10, 11, 34, 0.12),
        borderRadius: BorderRadius.all(Radius.circular(17.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(
              gradient: isAccount ? const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]):null,
              borderRadius: BorderRadius.circular(17.5),
            ),
            child: TextButton(onPressed: (){
              changed(1);
            }, child: Text("用户名注册", style: TextStyle(fontSize: 14, color: isAccount? Colors.white :  Color(0xFFB2B3BD))),),
          )),
          Expanded(child: Container(
            decoration: BoxDecoration(
              // color: const Color.fromRGBO(10, 11, 34, 0.12),
              gradient: isAccount == false ? const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]) : null ,
              borderRadius: BorderRadius.circular(17.5),
            ),
            child: TextButton(onPressed: (){
              changed(2);
            }, child: Text("邮箱注册", style: TextStyle(fontSize: 14, color: isAccount?  const Color(0xFFB2B3BD):Colors.white )),),
          ))
        ],
      )
    );
  }
}
