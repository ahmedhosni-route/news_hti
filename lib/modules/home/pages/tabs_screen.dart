import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_1am/core/services/Apis/api_manger.dart';
import 'package:news_1am/models/NewsModel.dart';

import '../../../models/sources_model.dart';

class TabsScreen extends StatefulWidget {
  final String catId;
  const TabsScreen({required this.catId,super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.getSources(widget.catId),
      builder: (context, snapshot) {
        List<Sources> sources = snapshot.data?.sources ?? [];
        return Column(
          children: [
            DefaultTabController(
                length: sources.length,
                child: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.all(3),
                    indicatorColor: Colors.transparent,
                    onTap: (value) {
                      selectedIndex = value;
                      setState(() {});
                    },
                    tabs: sources.map((s) {
                      return Tab(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: sources.indexOf(s) == selectedIndex
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            s.name ?? "",
                            style: TextStyle(
                              color: sources.indexOf(s) == selectedIndex
                                  ? Colors.white
                                  : Colors.green,
                            ),
                          ),
                        ),
                      );
                    }).toList())),
            if (sources.length != 0)
              FutureBuilder(
                future: ApiManger.getNews(sources[selectedIndex].id ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else {
                    List<Articles> articles = snapshot.data?.articles ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          var article = articles[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage ?? "",
                                      width: double.infinity,
                                      height: 220,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                      const Center(
                                          child:
                                          CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Center(
                                          child: Icon(Icons.error)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(article.source?.name ?? ""),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    article.title ?? "",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(article.publishedAt
                                          ?.substring(0, 10) ??
                                          ""),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
          ],
        );
      },
    );
  }
}
