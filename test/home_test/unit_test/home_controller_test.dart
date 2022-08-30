import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jump_squadio/app/data/remote_data_sources/HomeApis.dart';
import 'package:jump_squadio/core/values/app_constants.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeApis extends Mock implements HomeApis {}

void main() {
  group("Testing Api requests", () {
    final mockHomeApis = MockHomeApis();
    List<int> Stories = [];
    final dio = Dio();
    dio.options.baseUrl = AppConstants.kBaseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    test("Testing get top stories api and expecting get list of top stories",
        () async {
      dio.get("/topstories.json").then((response) {
        expect(response.statusCode, 200);
        expect(response.data is List<int>, true);
        expect(response.data, isA<List<int>>);
        Stories = response.data;
        Stories.forEach((element) {
          dio.get("/item/$element.json").then((response) {
            expect(response.statusCode, 200);
            expect(response.data is Map<String, dynamic>, true);
            expect(response.data, isA<Map<String, dynamic>>);
          });
        });
      });
    });
    test("Testing get new stories api and expecting get list of top stories",
        () async {
      dio.get("/newstories.json").then((response) {
        expect(response.statusCode, 200);
        expect(response.data is List<int>, true);
        expect(response.data, isA<List<int>>);
        Stories = response.data;
        Stories.forEach((element) {
          dio.get("/item/$element.json").then((response) {
            expect(response.statusCode, 200);
            expect(response.data is Map<String, dynamic>, true);
            expect(response.data, isA<Map<String, dynamic>>);
          });
        });
      });
    });
    test("Testing get best stories api and expecting get list of top stories",
        () async {
      dio.get("/beststories.json").then((response) {
        expect(response.statusCode, 200);
        expect(response.data is List<int>, true);
        expect(response.data, isA<List<int>>);
        Stories = response.data;
        Stories.forEach((element) {
          dio.get("/item/$element.json").then((response) {
            expect(response.statusCode, 200);
            expect(response.data is Map<String, dynamic>, true);
            expect(response.data, isA<Map<String, dynamic>>);
          });
        });
      });
    });
  });
}
