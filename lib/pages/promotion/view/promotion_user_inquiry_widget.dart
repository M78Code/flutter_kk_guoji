import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KKPromotionUserInquiryWidget extends StatelessWidget {
  const KKPromotionUserInquiryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.w,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.w,
                  childAspectRatio: 110 / 63
              ),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: const Color(0x1F6A6CB2),
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("推荐码", style: TextStyle(color: Colors.white, fontSize: 12),),
                      SizedBox(height: 8,),
                      Text("7455749", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ],
                  ),
                ); // Passing index + 1 as item number
              },
            ),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("账户ID", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  Text("上级ID", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  Text("总业绩", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return  Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 52.5, child: Center(
                        child: Text("100348", style: TextStyle(color: Colors.white, fontSize: 14),),
                      ),),
                      SizedBox(width: 82.5, child: Center(
                        child: Text("100346", style: TextStyle(color: Colors.white, fontSize: 14),),
                      ),),
                      Text("1000.00", style: TextStyle(color: Colors.white, fontSize: 12),),
                    ],
                  ),
                );
              }, itemCount: 10,)
          ],
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
