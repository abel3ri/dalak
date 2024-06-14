import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class ContentController {
  static Future<Either<ErrorMessage, List<Map<String, dynamic>>>> fetchData(
      String endpoint) async {
    try {
      final res = await dio.get('${BASE_URL}/${endpoint}');
      print(res);
      return right(List<Map<String, dynamic>>.from(res.data));
    } on DioException catch (_) {
      return left(ErrorMessage(body: "Error fetching content."));
    } catch (e) {
      return left(ErrorMessage(body: "An error has occured."));
    }
  }
}
