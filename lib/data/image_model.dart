import 'dart:convert';

import 'package:api_example/core/secrets.dart';
import 'package:http/http.dart' as http;

class ImageModel {
  String? title;
  String? explanation;
  DateTime? date;
  String? url;
  String? hdurl;

  ImageModel({
    this.title,
    this.explanation,
    this.date,
    this.url,
    this.hdurl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      title: json['title'] as String?,
      explanation: json['explanation'] as String?,
      date: DateTime.parse(json['date'] as String),
      url: json['url'] as String?,
      hdurl: json['hdurl'] as String?,
    );
  }
}

class ImageRemoteData {
  static const String _baseUrl = 'api.nasa.gov';
  static const String _path = '/planetary/apod';

  Map<String, String> _queryParameters = {
    'api_key': secretKey,
  };

  Future<ImageModel> fetchImage([DateTime? date]) async {
    if (date != null) {
      String dateStr = "${date.year}-${date.month}-${date.day}";
      _queryParameters['date'] = dateStr;
    }

    final uri = Uri.https(_baseUrl, _path, _queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return ImageModel.fromJson(json);
    }
    throw Exception('Failed to load image');
  }

  Future<List<ImageModel>> fetchImages(
      DateTime startDate, DateTime endDate) async {
    String startStr = "${startDate.year}-${startDate.month}-${startDate.day}";
    String endStr = "${endDate.year}-${endDate.month}-${endDate.day}";

    _queryParameters['start_date'] = startStr;
    _queryParameters['end_date'] = endStr;

    final uri = Uri.https(_baseUrl, _path, _queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => ImageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load images');
  }
}

