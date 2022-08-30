import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:jump_squadio/app/data/models/hacker_news_item_model.dart';
import 'package:jump_squadio/app/modules/home/views/widgets/tab_bar.dart';
import 'package:jump_squadio/core/resourses/color_manager.dart';
import 'package:jump_squadio/core/resourses/font_styles_manager.dart';
import 'package:jump_squadio/core/resourses/size_manager.dart';
import 'package:jump_squadio/core/values/assets.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: TabBarAndTabViews(
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
          return ListView.separated(
            itemCount: snapshot.data?.length ?? 0,
            separatorBuilder: (context, index) => const Divider(
              color: ColorsManger.primary,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items?[index].title ?? ""),
                trailing: Column(
                  children: [
                    SvgPicture.asset(Assets.kChat),
                    Text(items?[index].kids?.length.toString() ?? "0")
                  ],
                ),
                subtitle: Text(
                  items?[index].score.toString() ?? "",
                  style: getLightTextStyle(
                    color: ColorsManger.primary,
                  ),
                ),
                leading: const Icon(
                  Icons.arrow_drop_up_rounded,
                  size: AppSize.size20 * 2,
                ),
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
