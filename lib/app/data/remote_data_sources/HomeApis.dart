import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:jump_squadio/app/modules/home/controllers/home_controller.dart';
import 'package:jump_squadio/core/values/app_constants.dart';

import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../models/hacker_news_item_model.dart';

class HomeApis {
  Future<List<HackerNewsItem>> getTopNews() async {
    Dio dio = Dio();
    dio.options.baseUrl = AppConstants.kBaseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    Response response = await dio.get('/topstories.json');

    List<int> topNews = [];
    topNews.addAll(response.data.cast<int>());
    List<HackerNewsItem> items = [];
    Get.log('topNews: ${topNews.length}');
    for (int i = 0; i < 10; i++) {
      final request = NetworkRequest(
        type: NetworkRequestType.GET,
        path: 'item/${topNews[i]}.json',
        data: const NetworkRequestBody.json(
          {},
        ),
      );
      // Execute a request and convert response to your model:
      final response = await networkService.execute(
        request,
        HackerNewsItem
            .fromJson, // <- Function to convert API response to your model
      );

      response.maybeWhen(
          ok: (authResponse) {
            HackerNewsItem item = authResponse;
            Get.log('item: $item');
            items.add(item);
          },
          orElse: () {});
    }
    return items;
  }

  Future<List<HackerNewsItem>> getNewNews() async {
    Dio dio = Dio();
    dio.options.baseUrl = AppConstants.kBaseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    Response response = await dio.get('/newstories.json');

    List<int> topNews = [];
    topNews.addAll(response.data.cast<int>());
    List<HackerNewsItem> items = [];
    Get.log('topNews: ${topNews.length}');
    for (int i = 0; i < 10; i++) {
      final request = NetworkRequest(
        type: NetworkRequestType.GET,
        path: 'item/${topNews[i]}.json',
        data: const NetworkRequestBody.json(
          {},
        ),
      );
      // Execute a request and convert response to your model:
      final response = await networkService.execute(
        request,
        HackerNewsItem
            .fromJson, // <- Function to convert API response to your model
      );

      response.maybeWhen(
          ok: (authResponse) {
            HackerNewsItem item = authResponse;
            Get.log('item: $item');
            items.add(item);
          },
          orElse: () {});
    }
    return items;
  }

  Future<List<HackerNewsItem>> getBestNews() async {
    Dio dio = Dio();
    dio.options.baseUrl = AppConstants.kBaseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    Response response = await dio.get('/beststories.json');

    List<int> topNews = [];
    topNews.addAll(response.data.cast<int>());
    List<HackerNewsItem> items = [];
    Get.log('topNews: ${topNews.length}');
    for (int i = 0; i < 10; i++) {
      final request = NetworkRequest(
        type: NetworkRequestType.GET,
        path: 'item/${topNews[i]}.json',
        data: const NetworkRequestBody.json(
          {},
        ),
      );
      // Execute a request and convert response to your model:
      final response = await networkService.execute(
        request,
        HackerNewsItem
            .fromJson, // <- Function to convert API response to your model
      );

      response.maybeWhen(
          ok: (authResponse) {
            HackerNewsItem item = authResponse;
            Get.log('item: $item');
            items.add(item);
          },
          orElse: () {});
    }
    return items;
  }
}
