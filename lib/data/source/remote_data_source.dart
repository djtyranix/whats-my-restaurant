import 'dart:convert';

import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<Map<String, dynamic>> request(ApiRequest request, String? pathId, Map<String, dynamic>? payload, Map<String, dynamic>? query);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<Map<String, dynamic>> request(ApiRequest request, String? pathId, Map<String, dynamic>? payload, Map<String, dynamic>? query) async {
    var authority = request.authority();
    var pathUrl = request.requestUrl();

    // Check if need id appended to path
    if (request.isNeedId()) {
      if (pathId == null) {
        throw Exception('No pathId is supplied!');
      }
      
      pathUrl = '$pathUrl/$pathId';
    }

    var url = Uri.https(authority, pathUrl, query);

    if (request.requestType() == ApiRequestType.post) {
      return await postRequest(request, url, payload);
    } else {
      return await getRequest(request, url);
    }
  }

  Future<Map<String, dynamic>> postRequest(ApiRequest request, Uri url, Map<String, dynamic>? payload) async {
    final response = await http.post(url, body: payload);

    if (response.isSuccess()) {
      // Api call success
      return jsonDecode(response.body);
    } else {
      // Api call failed
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getRequest<T>(ApiRequest request, Uri url) async {
    final response = await http.get(url);

    if (response.isSuccess()) {
      // Api call success
      return jsonDecode(response.body);
    } else {
      // Api call faileds
      throw Exception('Error ${response.statusCode}');
    }
  }
}