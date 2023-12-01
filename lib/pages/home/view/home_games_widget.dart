
import 'package:flutter/material.dart';

class KKHomeGamesWidget extends StatelessWidget {
  const KKHomeGamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("KK游戏", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 13),),
                Text("KK推荐", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              children: [
                Text("查看全部", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),),
                SizedBox(height: 5,),
                Icon(Icons.chevron_right_outlined, size: 24, color: Color(0xFFB2B3BD),)
              ],
            )
          ],
        ),
        const SizedBox(height: 15,),
        SizedBox(
          width: double.infinity,
          height: 216,
          child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 108/78.0, crossAxisSpacing: 10, mainAxisSpacing: 24), itemBuilder: (context, index) {
            return Container(
              height: 108,
              color: Colors.red,
            );
          }),
        ),

      ],
    );
  }
}
