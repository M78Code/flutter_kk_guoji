import 'package:flutter/material.dart';
import 'package:kkguoji/utils/route_util.dart';


class KKCustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool showLeading;
  final String titleStr;
  final Function? leadActionCallback;
  const KKCustomAppBar(this.titleStr,{this.leadActionCallback,this.showLeading = true,super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleStr, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
      leading: showLeading? SizedBox(
        width: 40,
        height: 40,
        child: TextButton(onPressed: (){
          if(leadActionCallback != null) {
            leadActionCallback!();
          }else {
            RouteUtil.popView();
          }
        }, child: Image.asset("assets/images/back_normal.png", width: 20, height: 20,)),
      ):null,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  //在AppBar下方添加一条白色线
                    color: Color.fromRGBO(255, 255, 255, 0.06),
                    width: 1))),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(200, 44);
}
