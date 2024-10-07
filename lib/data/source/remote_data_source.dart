import 'dart:convert';

import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<Map<String, dynamic>> request(ApiRequest request, String? pathId, Map<String, dynamic>? payload, Map<String, dynamic>? query, {http.Client? client});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<Map<String, dynamic>> request(ApiRequest request, String? pathId, Map<String, dynamic>? payload, Map<String, dynamic>? query, {http.Client? client}) async {
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
      return await postRequest(request, url, payload, client: client);
    } else {
      return await getRequest(request, url, client: client);
    }
  }

  Future<Map<String, dynamic>> postRequest(ApiRequest request, Uri url, Map<String, dynamic>? payload, {http.Client? client}) async {
    final response = client != null
    ? await client.post(url, body: payload)
    : await http.post(url, body: payload);

    if (response.isSuccess()) {
      // Api call success
      return jsonDecode(response.body);
    } else {
      // Api call failed
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getRequest<T>(ApiRequest request, Uri url, {http.Client? client}) async {
    final response = client != null
    ? await client.get(url)
    : await http.get(url);

    if (response.isSuccess()) {
      // Api call success
      return jsonDecode(response.body);
    } else {
      // Api call faileds
      throw Exception('Error ${response.statusCode}');
    }
  }
}