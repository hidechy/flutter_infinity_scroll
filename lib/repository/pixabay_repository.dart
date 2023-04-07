// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart';

import '../data/api.dart';

///
class PixabayRepository extends Api {
  final String _pathName = "/api/";

  PixabayApiRequest pixabayApiInitialRequest =
      PixabayApiRequest(key: "22411457-7d1d2b683baff994d373da9ed", lang: "ja");

  ///
  Future<PixabayApiResponse> getPixabay(
      PixabayApiRequest pixabayApiRequest) async {
    Map<String, dynamic> queryParameters =
        generatePixabayApiQueryParameters(pixabayApiRequest);

    print(queryParameters);

    Response response = await pixabayApi(_pathName, queryParameters);

    Map<String, dynamic> JsonResponse = {};

    if (response.statusCode == 200) {
      JsonResponse = jsonDecode(response.body);
    } else {
      print("API通信でエラーが発生しました");
    }

    List<Hit> hitsList =
        transformPixabayApiResponseHitsIntoHitList(JsonResponse["hits"]);

    return PixabayApiResponse(
      total: JsonResponse["total"],
      totalHits: JsonResponse["totalHits"],
      hits: hitsList,
    );
  }

  ///
  Map<String, dynamic> generatePixabayApiQueryParameters(
      PixabayApiRequest pixabayApiRequest) {
    return {
      "key": pixabayApiRequest.key,
      "q": pixabayApiRequest.q ?? "",
      "lang": pixabayApiRequest.lang ?? "",
      "id": pixabayApiRequest.id ?? "",
      "image_type": pixabayApiRequest.imageType ?? "",
      "orientation": pixabayApiRequest.orientation ?? "",
      "category": pixabayApiRequest.category ?? "",
      "min_width": pixabayApiRequest.minWidth ?? "",
      "colors": pixabayApiRequest.colors ?? "",
      "editors_choice": pixabayApiRequest.editorsChoice ?? "",
      "safesearch": pixabayApiRequest.safesearch ?? "",
      "order": pixabayApiRequest.order ?? "",
      "page": pixabayApiRequest.page ?? "",
      "per_page": pixabayApiRequest.perPage ?? "",
      "callback": pixabayApiRequest.callback ?? "",
      "pretty": pixabayApiRequest.pretty ?? "",
    };
  }

  ///
  List<Hit> transformPixabayApiResponseHitsIntoHitList(
      List<dynamic> responseHits) {
    List<Hit> hitsList = [];

    for (var element in responseHits) {
      Hit hit = Hit(
          id: element["id"],
          pageURL: element["pageURL"],
          type: element["type"],
          tags: element["tags"],
          previewURL: element["previewURL"],
          previewWidth: element["previewWidth"],
          previewHeight: element["previewHeight"],
          webformatURL: element["webformatURL"],
          webformatWidth: element["webformatWidth"],
          webformatHeight: element["webformatHeight"],
          largeImageURL: element["largeImageURL"],
          imageWidth: element["imageWidth"],
          imageHeight: element["imageHeight"],
          imageSize: element["imageSize"],
          views: element["views"],
          downloads: element["downloads"],
          collections: element["collections"],
          likes: element["likes"],
          comments: element["comments"],
          userId: element["user_id"],
          user: element["user"],
          userImageURL: element["userImageURL"]);
      hitsList.add(hit);
    }

    return hitsList;
  }
}

///
class PixabayApiRequest {
  PixabayApiRequest(
      {required this.key,
      this.q,
      this.lang,
      this.id,
      this.imageType,
      this.orientation,
      this.category,
      this.minWidth,
      this.minHeight,
      this.colors,
      this.editorsChoice,
      this.safesearch,
      this.order,
      this.page,
      this.perPage,
      this.callback,
      this.pretty});

  String key;
  String? q;
  String? lang;
  String? id;
  String? imageType;
  String? orientation;
  String? category;
  int? minWidth;
  int? minHeight;
  String? colors;
  bool? editorsChoice;
  bool? safesearch;
  String? order;
  String? page;
  int? perPage;
  String? callback;
  bool? pretty;
}

///
class PixabayApiResponse {
  PixabayApiResponse(
      {required this.total, required this.totalHits, required this.hits});

  int total;
  int totalHits;
  List<Hit> hits;
}

///
class Hit {
  Hit({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  int id;
  String pageURL;
  String type;
  String tags;
  String previewURL;
  int previewWidth;
  int previewHeight;
  String webformatURL;
  int webformatWidth;
  int webformatHeight;
  String largeImageURL;
  int imageWidth;
  int imageHeight;
  int imageSize;
  int views;
  int downloads;
  int collections;
  int likes;
  int comments;
  int userId;
  String user;
  String userImageURL;
}
