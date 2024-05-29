import 'dart:convert';
import 'package:http/http.dart';
import '../model/bitcoin_model.dart';

class Network {
  static String BASE = "newsapi.org";

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Apis*/
  static String API_GET_BITCOIN = "/v2/everything";

  /* Http Params */

  static Map<String, String> paramsArticle() {
    Map<String, String> params = {};
    params.addAll({
      'q': "bitcoin",
      'sortBy': 'publishedAt',
      'apiKey': '10395562431f436cb3c8b019e16ac16a'
    });
    return params;
  }

  // String? encodeQueryParameters(Map<String, String> params) {
  //   return params.entries
  //       .map((MapEntry<String, String> e) =>
  //   '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
  //       .join('&');
  // }

  /* Http Parsing */

  static List<Article> parseArticles(String response) {
    dynamic json = jsonDecode(response);
    return RandomBitcoinListRes.fromJson(json).articles;
  }
}