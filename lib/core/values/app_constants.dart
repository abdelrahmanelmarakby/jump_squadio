import '../services/network_service.dart/dio_network_service.dart';

//Network global data
NetworkService networkService = NetworkService(
  baseUrl: AppConstants.kBaseUrl,
  httpHeaders: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);

class AppConstants {
  const AppConstants._();
  static const String kBaseUrl = "https://hacker-news.firebaseio.com/v0/";
}
