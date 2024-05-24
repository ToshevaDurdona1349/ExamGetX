import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/bitcoin_model.dart';
import '../service/http_service.dart';


class HomeController extends GetxController {
  List<Article> articles = [];

  loadData() async {
    var response =
    await Network.GET(Network.API_GET_BITCOIN, Network.paramsArticle());
    List<Article> articlesList = Network.parseArticles(response!);
    print(articlesList.length);

    articles = articlesList;
    update();
  }
}