
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/customer/logic/logic.dart';
import 'package:kkguoji/widget/custome_app_bar.dart';

class KKCustomerServicePage extends StatelessWidget {
  KKCustomerServicePage({super.key});

  final controller = Get.find<CustomerLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KKCustomAppBar("客服"),
      body: Container(
        color: const Color(0xFF171A26),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() {
          return _buildItem("Telegrame", controller.customerMap.value["site_telegram"] ?? "", "assets/images/service/service_Telegrame.png");
        })
      ),
    );
  }
  
  Widget _buildItem(String name, String content, String imageStr) {
    return  Column(
      children: [
        Row(
          children: [
            Image.asset(imageStr, width: 23, height: 23,),
            const SizedBox(width: 5,),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 14),),
          ],
        ),
        const SizedBox(height: 5,),
        Container(
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(108, 122, 143, 0.24),
            borderRadius: BorderRadius.circular(20.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(content, style: const TextStyle(color: Colors.white, fontSize: 14),),
               TextButton(onPressed: (){

               }, child:const Text("立即沟通", style: TextStyle(color: Color(0xFF5D5FEF), fontSize: 14),) )
             ],
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}
