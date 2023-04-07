import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/search_result_state.dart';
import 'components/image_card.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      appBar: AppBar(
        centerTitle: true,
        title: const Text("検索結果"),
      ),

      //

      body: Consumer(
        builder: (context, ref, child) {
          final searchResult = ref.watch(searchResultProvider);

          ScrollController scrollController;
          bool isLoading = false;

          scrollController = ScrollController();

          scrollController.addListener(
            () async {
              if (scrollController.position.pixels >=
                      scrollController.position.maxScrollExtent * 0.95 &&
                  !isLoading) {
                isLoading = true;
                ref.read(pageProvider.notifier).state++;
                await ref.read(searchResultProvider.notifier).addImageList();
                isLoading = false;
              }
            },
          );

          return searchResult.when(
            data: (searchResult) {
              int hitCount = searchResult.hitCount;
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$hitCount",
                          style:
                              const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        const Text(
                          " 件のヒット",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: searchResult.imageList.length,
                      itemBuilder: (context, int index) {
                        //

                        if (searchResult.imageList.length == index + 1) {
                          return Center(
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        }

                        return ImageCard(
                          imageUrl: searchResult.imageList[index].imageUrl,
                          likes: searchResult.imageList[index].likes,
                          views: searchResult.imageList[index].views,
                        );

                        //
                      },
                    ),
                  ),
                ],
              );
            },
            error: (err, stack) => const Center(child: Text("エラーが発生しました")),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),

      //
    );
  }
}
