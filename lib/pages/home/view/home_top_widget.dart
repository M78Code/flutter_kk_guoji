
import 'dart:ffi';

import 'package:flutter/material.dart';

class KKHomeTopWidget extends StatelessWidget {
  const KKHomeTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color.fromRGBO(17, 22, 60, 1.0), Color.fromRGBO(5, 8, 32, 0.0)],
        )
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 44, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/home_top_logo.png", width: 115, height: 30,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 67,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: TextButton(style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: (){

                    },child: const Text("登录",  style: TextStyle(color: Colors.white, fontSize: 13),),),
                  )
                ),
                const SizedBox(width: 10,),
                Container(
                  width: 67,
                  height: 27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color.fromRGBO(108, 79, 224, 0.6),
                          Color.fromRGBO(63, 54, 199, 0.6),
                          Color.fromRGBO(131, 67, 212, 0.6),
                          Color.fromRGBO(143, 79, 224, 0.6)],
                      )
                  ),
                  child:  TextButton(style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                    onPressed: (){

                  },child: const Text("注册", style: TextStyle(color: Colors.white, fontSize: 14),),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


