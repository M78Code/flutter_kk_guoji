
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String imageStr;
  final String hintText;
  ValueChanged<String>? valueChanged;
  final TextInputType keybordType;
  Widget? rightWidget;
  final bool isObscureText;
  CustomInputField(this.imageStr, this.hintText, {this.valueChanged,this.rightWidget,this.isObscureText = false, this.keybordType = TextInputType.text, super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        color: Color(0x3D6C7A8F),
        borderRadius: BorderRadius.all(Radius.circular(21)),
      ),
      height: 42,
      child: Row(
         children: [
           SizedBox(
             width: 60,
             child: Image.asset(imageStr, width: 30, height: 30,),
           ),
           Expanded(child: TextField(
             decoration: InputDecoration(
               hintText: hintText,
               border: InputBorder.none,
               hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
             ),
             textAlign: TextAlign.start,
             style: const TextStyle(color: Colors.white, fontSize: 16),
             cursorColor: Colors.white,
             onChanged: (value) {
               if(valueChanged != null) {
                 valueChanged!(value);
               }
             },
             obscureText: isObscureText,

           )),
           Container(
             child: rightWidget != null ? rightWidget!: null,
           )
         ],
      ),
    );
  }
}
