import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'webview_page.dart';
import '../controller/home_controller.dart';
import '../model/bitcoin_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    homeController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Information about Bitcoin at GetX"),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: homeController.articles.length,
                itemBuilder: (context, index) {
                  return itemOfArticle(homeController.articles[index], index);
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget itemOfArticle(Article article, int index) {
    return GestureDetector(
      onTap: () {
        _launchUrl(article.url);
      },
      onLongPress: () {
        Get.to(WebviewPage(url: article.url));
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "${index} - ${article.title}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              article.description.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: article.urlToImage.toString(),
                  placeholder: (context, url) => Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                    child: const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.content,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                      Text(
                        article.author.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.blue),
                      ),
                      Text(
                        article.publishedAt.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
