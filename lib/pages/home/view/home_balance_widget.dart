
import 'package:flutter/material.dart';

class KKHomeBalanceWidget extends StatelessWidget {
  const KKHomeBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E374C), Color(0xFF181E2F)],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("请登录", style: TextStyle(color: Colors.white, fontSize: 14),),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("¥0.00", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, fontFamily: "DINPro-Bold"),),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: TextButton(onPressed: (){

                    },
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero)
                      ),
                      child: Image.asset("assets/images/home_refresh_icon.png",width: 18, height: 18,fit: BoxFit.fitWidth,),
                    ),
                  )

                ],
              )
            ],
          ),
          const SizedBox(width:30,),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/home_cunkuan_icon.png", width: 27, height: 25,),
                    const SizedBox(height: 10,),
                    const Text("存款", style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/home_qukuan_icon.png", width: 27, height: 25,),
                    const SizedBox(height: 10,),
                    const Text("取款", style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/home_vip_icon.png", width: 27, height: 25,),
                    const SizedBox(height: 10,),
                    const Text("VIP", style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/home_danzhu_icon.png", width: 27, height: 25,),
                    const SizedBox(height: 10,),
                    const Text("单住", style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
