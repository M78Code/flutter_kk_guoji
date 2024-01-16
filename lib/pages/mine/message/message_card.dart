import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/message/message_model.dart';
import 'package:kkguoji/pages/mine/message/message_service.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/route_util.dart';

class MeeageCard extends StatefulWidget {
  final MessageListModel messageModel;
  MeeageCard({super.key, required this.messageModel});

  @override
  State<MeeageCard> createState() => _MeeageCardState();
}

class _MeeageCardState extends State<MeeageCard> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
          color: const Color(0xFF222633),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _creatTime(widget.messageModel),
                const SizedBox(height: 5),
                _titleView(widget.messageModel),
                const SizedBox(height: 5),
                _showImage(widget.messageModel),
                const SizedBox(height: 5),
                _contentView(widget.messageModel),
                const SizedBox(height: 10),
                _isShowAllConten(widget.messageModel),
                const SizedBox(height: 15),
                if (!widget.messageModel.linkTitle.isEmpty)
                  const Positioned(
                    child: Divider(
                      color: Color.fromRGBO(255, 255, 255, 0.06),
                      height: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                const SizedBox(height: 10),
                if (!widget.messageModel.linkTitle.isEmpty)
                  _textUrlShow(widget.messageModel),
                if (!widget.messageModel.linkTitle.isEmpty)
                  const SizedBox(
                    height: 20,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //时间
  Widget _creatTime(MessageListModel model) {
    return Positioned(
      child: Text(
        model.createTime,
        style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  //标题
  Widget _titleView(MessageListModel model) {
    return Positioned(
      child: Text(
        model.title,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }

  //图片
  Widget _showImage(MessageListModel model) {
    return Positioned(
        child: model.image != null
            ? Image.network('${model.image}')
            : const SizedBox(height: 0));
  }

  //富文本xtml
  Widget _contentView(MessageListModel model) {
    return Positioned(
        child: Column(
      children: [
        Html(
          data: model.content,
          style: {
            '#': Style(
              color: model.isShow ? Colors.white : Color(0xFF686F83),
              fontSize: FontSize(12),
              maxLines: model.isShow ? 100000 : 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          },
        )
      ],
    ));
  }

  Widget _isShowAllConten(MessageListModel model) {
    return Positioned(
      child: GestureDetector(
        child: Row(
          children: [
            const Expanded(child: Text('')), //用这个设置在右边
            Text(
              model.isShow ? '收起' : '显示所有',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 5),
            model.isShow
                ? Image.asset(
                    Assets.imagesIconUp,
                    width: 12,
                    height: 12,
                  )
                : Image.asset(
                    Assets.imagesIconDown,
                    width: 12,
                    height: 12,
                  ),
          ],
        ),
        onTap: () {
          setState(() {
            model.isShow = !model.isShow;
            MessageService.getReadNotice(model.id);
          });
        },
      ),
    );
  }

  Widget _textUrlShow(MessageListModel model) {
    return Positioned(
      child: GestureDetector(
        child: Row(
          children: [
            Text(
              model.linkTitle,
              style: const TextStyle(
                  color: Color(0xFF5D5FEF),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            const Expanded(child: Text('')), //用这个设置左右一个
            Image.asset(
              Assets.imagesIconArrowsBlue,
              width: 18,
              height: 18,
            )
          ],
        ),
        onTap: () {
          if (!model.linkTitle.isEmpty) {
            RouteUtil.pushToView(Routes.webView, arguments: model.link);
          }
        },
      ),
    );
  }
}
