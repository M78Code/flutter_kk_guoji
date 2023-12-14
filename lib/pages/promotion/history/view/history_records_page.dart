
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/widget/custome_app_bar.dart';

class KKHistoryRecordsPage extends StatelessWidget {
  const KKHistoryRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KKCustomAppBar("历史记录"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(child: ),
                  Container(
                    height: 41,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xFF222633)
                    ),
                    child: Row(
                      children: [
                        _buildDateWidget("今天", true),
                        _buildDateWidget("昨天", false),
                        _buildDateWidget("本月", false),
                        _buildDateWidget("上月", false),

                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(child: Container(
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFF222633),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 5,),
                        const Expanded(child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              hintText: "搜索玩家ID",
                              hintStyle: TextStyle(color: Color(0xFF687083), fontSize: 12),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 25, color: Color(0xFF687083),)),
                      ],
                    ),
                  ),)
                ],
              ),
              const SizedBox(height: 15,),
              Container(
                color: const Color(0x1F6A6CB2),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text("时间", style: TextStyle(color: const Color(0xFFB2B3BD), fontSize: 12.w),),)),
                    Expanded(child: Center(child: Text("金额", style: TextStyle(color: const Color(0xFFB2B3BD), fontSize: 12.w),),))
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Center(
                          child: Text("2023-11-18 10:04:24", style: TextStyle(color: Colors.white, fontSize: 14.w),),
                        )),
                        Expanded(child: Center(
                          child: Text("+13231.00", style: TextStyle(color: Colors.white, fontSize: 14.w),),
                        )),
                        // SizedBox(width: 52.5, child: Center(
                        //   child: Text("100348", style: TextStyle(color: Colors.white, fontSize: 14),),
                        // ),),
                        // SizedBox(width: 82.5, child: Center(
                        //   child: Text("100346", style: TextStyle(color: Colors.white, fontSize: 14),),
                        // ),),
                        // Text("1000.00", style: TextStyle(color: Colors.white, fontSize: 12),),
                      ],
                    ),
                  );
                }, itemCount: 10,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateWidget(String text, bool isSelected) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
        gradient: isSelected? const LinearGradient(colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)]):null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        child: Text(text, style: TextStyle(color: isSelected? Colors.white:const Color(0xFF707A8C), fontSize: 12),),
        onPressed: (){

        },
      ),
    );
  }

}
