import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:jump_squadio/app/data/models/comment_model.dart';
import 'package:jump_squadio/app/data/models/hacker_news_item_model.dart';
import 'package:jump_squadio/app/data/remote_data_sources/HomeApis.dart';
import 'package:jump_squadio/app/modules/home/views/widgets/tab_bar.dart';
import 'package:jump_squadio/app/routes/app_pages.dart';
import 'package:jump_squadio/core/resourses/color_manager.dart';
import 'package:jump_squadio/core/resourses/font_manager.dart';
import 'package:jump_squadio/core/resourses/font_styles_manager.dart';
import 'package:jump_squadio/core/resourses/size_manager.dart';
import 'package:jump_squadio/core/values/assets.dart';

import '../../../comment/views/comment_view.dart';
import '../../controllers/home_controller.dart';

class Story extends GetWidget<HomeController> {
  const Story({Key? key, required this.story}) : super(key: key);
  final HackerNewsItem story;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>?>(
      future: HomeApis().getComments(comments: story.kids ?? []),
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
                      Text(story.score.toString(),
                          style: getBoldTextStyle(
                              color: ColorsManger.primary,
                              fontSize: FontSize.large)),
                    ],
                  ),
                  Text(story.title ?? "",
                      style: getBoldTextStyle(color: ColorsManger.primary)),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: ColorsManger.primary,
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: HtmlWidget(
                        comments?[index].text ?? "N/A",
                      ),
                      subtitle: comments![index].kids?.isNotEmpty ?? false
                          ? CommentView(comments[index])
                          : SizedBox(),
                      leading: Column(
                        children: [
                          SvgPicture.asset(Assets.kChat),
                          Text((comments?[index].kids?.length ?? 0).toString())
                        ],
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
    );
  }
}
