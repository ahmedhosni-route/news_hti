import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:news_1am/modules/home/manager/home_view_model.dart';

import '../../../models/sources_model.dart';

class TabsScreen extends StatefulWidget {
  HomeViewModel viewModel;
  TabsScreen({required this.viewModel, super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.viewModel.getSources();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.viewModel.sources.length,
            child: TabBar(
                isScrollable: true,
                labelPadding: const EdgeInsets.all(3),
                indicatorColor: Colors.transparent,
                onTap: widget.viewModel.tabClicked,
                tabs: widget.viewModel.sources.map((s) {
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.viewModel.sources.indexOf(s) ==
                                widget.viewModel.selectedIndex
                            ? Colors.green
                            : Colors.white,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        s.name ?? "",
                        style: TextStyle(
                          color: widget.viewModel.sources.indexOf(s) ==
                                  widget.viewModel.selectedIndex
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  );
                }).toList())),
        if (widget.viewModel.sources.length != 0)
          Expanded(
            child: ListView.builder(
              itemCount: widget.viewModel.articles.length,
              itemBuilder: (context, index) {
                var article = widget.viewModel.articles[index];
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
          )
      ],
    );
  }
}
