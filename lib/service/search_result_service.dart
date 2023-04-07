import '../repository/pixabay_repository.dart';
import '../state/search_result_state.dart';

class SearchResultService {
  final PixabayRepository _pixabayRepository = PixabayRepository();

  ///
  Future<SearchResult> getSearchResultList(String q, int page) async {
    // pixabayリポジトリのパラメータ生成
    PixabayApiRequest pixabayApiRequest =
        _pixabayRepository.pixabayApiInitialRequest;

    pixabayApiRequest.q = q;

    pixabayApiRequest.page = page.toString();

    // pixabayリポジトリのAPI実行
    PixabayApiResponse pixabayApiResponse =
        await _pixabayRepository.getPixabay(pixabayApiRequest);

    // pixabayリポジトリからSearchResultリストに変換
    SearchResult searchResultList =
        transformPixabayApiResponseIntoSearchResult(pixabayApiResponse);

    return searchResultList;
  }

  ///
  SearchResult transformPixabayApiResponseIntoSearchResult(
      PixabayApiResponse pixabayApiResponse) {
    List<ImageList> imageList = [];

    for (Hit hit in pixabayApiResponse.hits) {
      ImageList image = ImageList(
        imageUrl: hit.webformatURL,
        views: hit.views,
        likes: hit.likes,
      );

      imageList.add(image);
    }

    return SearchResult(imageList, pixabayApiResponse.total);
  }
}
