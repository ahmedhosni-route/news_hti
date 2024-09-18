import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_1am/modules/home/cubit/cubit.dart';

import 'package:news_1am/modules/home/manager/home_view_model.dart';

import '../../../models/sources_model.dart';

class TabsScreen extends StatefulWidget {
  HomeCubit cubit;
  TabsScreen({required this.cubit, super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.cubit.getSources();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.cubit.sources.length,
            child: TabBar(
                isScrollable: true,
                labelPadding: const EdgeInsets.all(3),
                indicatorColor: Colors.transparent,
                onTap: widget.cubit.tabClicked,
                tabs: widget.cubit.sources.map((s) {
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.cubit.sources.indexOf(s) ==
                                widget.cubit.selectedIndex
                            ? Colors.green
                            : Colors.white,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        s.name ?? "",
                        style: TextStyle(
                          color: widget.cubit.sources.indexOf(s) ==
                                  widget.cubit.selectedIndex
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  );
                }).toList())),
        if (widget.cubit.sources.isNotEmpty)
          Expanded(
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.green,
              onRefresh: () async {
                await widget.cubit.getNews();
              },
              child: ListView.builder(
                itemCount: widget.cubit.articles.length,
                itemBuilder: (context, index) {
                  var article = widget.cubit.articles[index];
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
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
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
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(article.publishedAt?.substring(0, 10) ?? ""),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
      ],
    );
  }
}
