import 'package:dalak_blog_app/models/Error.dart';
import 'package:fpdart/fpdart.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlController {
  static Future<Either<ErrorMessage, void>> launchUrls(String url) async {
    try {
      final _url = Uri.parse(url);
      if (!await launchUrl(_url)) {
        throw Exception(["Error launching url"]);
      }
      return right(null);
    } catch (e) {
      print(e);
      return left(ErrorMessage(body: e.toString()));
    }
  }
}
