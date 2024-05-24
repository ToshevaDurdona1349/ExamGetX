
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/home_controller.dart';
import '../model/bitcoin_model.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();


  @override
  void initState() {
    // TODO: implement initState
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
                  return itemOfArticle(homeController.articles[index]);
                },
              )
            ],
          );
        }
      ),
    );
  }

  Widget itemOfArticle(Article article) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            imageUrl: article.urlToImage.toString(),
            placeholder: (context, url) => Container(
              height: 80,
              width: 80,
              color: Colors.grey,
            ),
            errorWidget: (context, url, error) => Container(
              height: 80,
              width: 80,
              color: Colors.grey,
              child: const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ${article.title} ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),

                Text(
                  article.author.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16,color:Colors.blue ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}