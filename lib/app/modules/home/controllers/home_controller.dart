import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jump_squadio/app/data/models/comment_model.dart';
import 'package:jump_squadio/app/data/models/hacker_news_item_model.dart';
import 'package:jump_squadio/app/data/remote_data_sources/HomeApis.dart';

class HomeController extends GetxController {
  late Future<List<HackerNewsItem>?> topStoriesIdsFuture;
  late Future<List<HackerNewsItem>?> newStoriesIdsFuture;
  late Future<List<HackerNewsItem>?> bestStoriesIdsFuture;
  late Future<List<Comment>?> getComments;
  List<HackerNewsItem> topStories = <HackerNewsItem>[];
  PageController pageViewController = PageController();

  @override
  void onInit() {
    topStoriesIdsFuture = HomeApis().getTopNews();
    newStoriesIdsFuture = HomeApis().getNewNews();
    bestStoriesIdsFuture = HomeApis().getBestNews();

    super.onInit();
  }
}
