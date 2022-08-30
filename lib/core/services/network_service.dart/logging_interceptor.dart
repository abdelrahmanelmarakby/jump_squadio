import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);
final dioLoggerInterceptor =
    InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  handler.next(options); //continue
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });

  logger.v(
      "┌------------------------------------------------------------------------------");
  logger.v('''| [DIO] Request: ${options.method} ${options.uri}
| ${options.data.toString()}
| Headers:\n$headers''');
  logger.v(
      "├------------------------------------------------------------------------------");
}, onResponse: (Response response, handler) async {
  handler.next(response);
  logger.i(
      "| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
  logger.i(
      "└------------------------------------------------------------------------------");

  // return response; // continue
}, onError: (DioError error, handler) async {
  handler.next(error); //continue
  /*  for (int i in [
    408,
    429,
    500,
    502,
    503,
    504,
    440,
    460,
    499,
    522,
    523,
    524,
    527,
    598,
    599
  ]) {
    if (error.response?.statusCode == i) {
      Get.log("Network error statuscode is : " + i.toString());
      await AuthApis().refreshToken().then((value) {
        print(value);
        Get.forceAppUpdate();
        return value;
      });
    }
  } */
  logger.wtf("---------------------------------------");
  logger.wtf("| [DIO] Error: ${error.error}: ${error.response?.toString()}" +
      error.type.toString() +
      error.message);
  logger.wtf(
      "└------------------------------------------------------------------------------");
});
