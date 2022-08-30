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

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: TabBarAndTabViews(
        tabPairs: [
          TabPair(
            tab: const Tab(text: "Top Stories"),
            view: StoriesView(
              controller.topStoriesIdsFuture,
            ),
          ),
          TabPair(
            tab: const Tab(text: "New Stories"),
            view: StoriesView(
              controller.newStoriesIdsFuture,
            ),
          ),
          TabPair(
            tab: const Tab(
              text: "Best Stories",
            ),
            view: StoriesView(
              controller.bestStoriesIdsFuture,
            ),
          )
        ],
      ),
    ));
  }
}

class StoriesView extends GetWidget<HomeController> {
  const StoriesView(this.storiesType, {Key? key}) : super(key: key);
  final Future<List<HackerNewsItem>?> storiesType;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HackerNewsItem>?>(
      future: storiesType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<HackerNewsItem>? items = snapshot.data;
          return PageView.builder(
            itemCount: snapshot.data?.length ?? 0,
            controller: controller.pageViewController,
            onPageChanged: (index) {
              //detect if the pages are finished
              if (index == (items?.length)! - 1) {
                //disable the pageview scroll
                controller.pageViewController.jumpToPage(0);

                //show the toast
                BotToast.showText(
                  text: "All the pages are finished",
                );
              }
            },
            itemBuilder: (context, index) {
              return Story(
                story: (items?[index])!,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }
}

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
                    return InkWell(
                      onTap: () {
                        if ((comments?[index].kids?.length ?? 0) > 0) {
                          Get.toNamed(Routes.COMMENT,
                              arguments: comments?[index]);
                        } else {
                          BotToast.showText(text: "No replies in this comment");
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
                            Text(
                                (comments?[index].kids?.length ?? 0).toString())
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
    );
  }
}
