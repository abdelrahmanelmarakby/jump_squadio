import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';

import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/font_manager.dart';
import '../../../../core/resourses/font_styles_manager.dart';
import '../../../../core/resourses/size_manager.dart';
import '../../../../core/values/assets.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/remote_data_sources/HomeApis.dart';
import '../../../routes/app_pages.dart';
import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Comment',
            style: getBoldTextStyle(color: ColorsManger.primary),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Comment>?>(
          future:
              HomeApis().getComments(comments: controller.comment.kids ?? []),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Comment>? comments = snapshot.data;
              Get.log("${comments?.length}");
              return Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_drop_up_rounded,
                            size: AppSize.size20,
                            color: ColorsManger.success,
                          ),
                          Expanded(
                            child: Text(controller.comment.text.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: getBoldTextStyle(
                                    color: ColorsManger.primary,
                                    fontSize: FontSize.large)),
                          ),
                        ],
                      ),
                      const Text(""),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: ColorsManger.primary,
                      ),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if ((comments?[index].kids?.length ?? 0) > 0) {
                              Get.offAndToNamed(Routes.COMMENT,
                                  arguments: comments?[index]);
                            } else {
                              BotToast.showText(
                                  text: "No replies in this comment");
                            }
                          },
                          child: ListTile(
                            title: HtmlWidget(
                              comments?[index].text ?? "N/A",
                            ),
                            subtitle: Text("By:  ${comments?[index].by}",
                                style: getMediumTextStyle(
                                  color: ColorsManger.primary,
                                )),
                            leading: Column(
                              children: [
                                SvgPicture.asset(Assets.kChat),
                                Text((comments?[index].kids?.length ?? 0)
                                    .toString())
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ));
  }
}
