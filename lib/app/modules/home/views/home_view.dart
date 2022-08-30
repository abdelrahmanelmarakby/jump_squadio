import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jump_squadio/app/data/models/hacker_news_item_model.dart';
import 'package:jump_squadio/app/modules/home/views/widgets/tab_bar.dart';

import '../controllers/home_controller.dart';
import 'widgets/story_widget.dart';

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
