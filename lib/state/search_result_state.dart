// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../service/search_result_service.dart';

part 'search_result_state.freezed.dart';

final searchQeuryProvider = StateProvider<String>((ref) => "");

final pageProvider = StateProvider<int>((ref) => 1);

///
final searchResultProvider =
    AsyncNotifierProvider<AsyncSearchQueryNotifier, SearchResult>(() {
  return AsyncSearchQueryNotifier();
});

///
class AsyncSearchQueryNotifier extends AsyncNotifier<SearchResult> {
  @override
  Future<SearchResult> build() async {
    return _fetchInitial();
  }

  final SearchResultService _searchResultService = SearchResultService();

  ///
  Future<SearchResult> _fetchInitial() async {
    String searchQuery = ref.watch(searchQeuryProvider);

    SearchResult searchResult =
        await _searchResultService.getSearchResultList(searchQuery, 1);

    return searchResult;
  }

  ///
  Future<void> addImageList() {
    return update((previousSearchResult) async {
      String searchQuery = ref.watch(searchQeuryProvider);

      int page = ref.read(pageProvider);

      List<ImageList> newImageList = [];

      for (ImageList image in previousSearchResult.imageList) {
        newImageList.add(image);
      }

      SearchResult searchResult =
          await _searchResultService.getSearchResultList(searchQuery, page);

      for (ImageList image in searchResult.imageList) {
        newImageList.add(image);
      }

      return SearchResult(newImageList, previousSearchResult.hitCount);
    });
  }
}

/////////////////////////////////////

///
@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult(List<ImageList> imageList, int hitCount) =
      _SearchResult;
}

///
class ImageList {
  ImageList({required this.imageUrl, required this.views, required this.likes});

  String imageUrl;
  int views;
  int likes;
}
