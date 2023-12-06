import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/ex_list.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';

import '../activity_model.dart';


/// 分类导航项
class CategoryListItemWidget extends StatelessWidget {
  /// 分类数据
  final CategoryModel category;

  /// 选中代码
  final int? selectId;

  /// tap 事件
  final Function(int categoryId)? onTap;

  const CategoryListItemWidget({
    Key? key,
    required this.category,
    this.onTap,
    this.selectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        category.name,
        style: TextStyle(
            color: selectId == category.index ? Colors.white : Color(0xFF707A8C),
            fontSize: 18.0)
    )
        .padding(vertical: 6.w, horizontal: 12.w)
        .backgroundColor(selectId == category.index ? Color(0xFF171A26) : Color(0xFF222633))
        .onTap(() => onTap?.call(category.index));
  }
}


class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final Function(int categoryId)? onTap;

  CategoryItem({
    required this.category,
    required this.isSelected,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected == category.index ? Color(0xFF171A26) : Color(0xFF222633),
        borderRadius: BorderRadius.circular(20.0),
        border: isSelected ? Border.all(
          color: const Color(0xFF3D35C6),
          width: 1.0,
        ) : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12,),
      child: Text(
        category.name,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF707A8C),
          fontSize: 13,
        ),
      ),
    ).onTap(() => onTap?.call(category.index));
  }
}

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;
  final Function(int activityId)? onTap;

  ActivityItem({required this.activity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        activity.imageUrl,
        fit: BoxFit.cover,
      ),
    ).onTap(() => onTap?.call(activity.id));
  }
}
