 import 'package:flutter/material.dart';

class KKPromotionRebateWidget extends StatelessWidget {
  const KKPromotionRebateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 41,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFF222633)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildTextButton("电子","assets/images/promotion/promotion_caipiao_selected.png",true),
                  _buildTextButton("视讯", "assets/images/promotion/promotion_caipiao_selected.png",false),
                  _buildTextButton("体育", "assets/images/promotion/promotion_caipiao_selected.png",false),
                  _buildTextButton("彩票", "assets/images/promotion/promotion_caipiao_selected.png",false),

                ],
              ),
            ),
            const SizedBox(height: 15,),
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
                      child: Text("有效投注量", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                    )
                  ),
                  SizedBox(
                      width:70,
                      child: Center(
                        child: Text("一级代理", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                      )
                  ),
                  SizedBox(
                      width:70,
                      child: Center(
                        child: Text("二级代理", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                      )
                  ),
                  SizedBox(
                      width:70,
                      child: Center(
                        child: Text("三级代理", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                      )
                  ),


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
              }, itemCount: 10,)
          ],
        ),
      )
    );
  }

  Widget _buildTextButton(String text,String imagePath, bool isSelected) {
    return Expanded(child: Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: isSelected? const LinearGradient(colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)]) : null,
          // border:isSelected? Border.all( color: const Color(0xFF3D35C6)):null
      ),
      child: TextButton(
          onPressed: (){

          },
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 24, height: 21,),
              const SizedBox(width: 8,),
              Text(text, style: TextStyle(color: isSelected? Colors.white: const Color(0xFF707A8C), fontSize: 13)),
            ],
          )
      ),
    ));
  }

}
