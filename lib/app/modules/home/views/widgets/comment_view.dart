import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:jump_squadio/app/modules/home/controllers/home_controller.dart';

import '../../../../../core/resourses/color_manager.dart';
import '../../../../../core/resourses/font_manager.dart';
import '../../../../../core/resourses/font_styles_manager.dart';
import '../../../../../core/resourses/size_manager.dart';
import '../../../../data/models/comment_model.dart';
import '../../../../data/remote_data_sources/HomeApis.dart';

class CommentView extends GetWidget<HomeController> {
  const CommentView(this.comment, {Key? key}) : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>?>(
      future: HomeApis().getComments(comments: comment.kids ?? []),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Comment>? comments = snapshot.data;
          Get.log("${comments?.length}");
          return SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: HtmlWidget(
                            comment.text.toString(),
                            textStyle: getLightTextStyle(
                              color: ColorsManger.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("${comment.by}",
                        style: getBoldTextStyle(
                            color: ColorsManger.primary,
                            fontSize: FontSize.large)),
                    const SizedBox(
                      height: AppSize.size20,
                    ),
                    Text("Comments",
                        textAlign: TextAlign.start,
                        style: getBoldTextStyle(color: ColorsManger.primary)),
                  ],
                ),
                Container(
                    height: 200,
                    width: 200,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                              color: ColorsManger.primary,
                            ),
                        itemCount: comments?.length ?? 0,
                        itemBuilder: (context, index) {
                          return comments![index].kids?.isNotEmpty ?? false
                              ? CommentView(comments[index])
                              : Text(comments[index].text.toString(),
                                  style: getLightTextStyle(
                                      color: ColorsManger.primary));
                        })),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}
