import 'dart:developer';
import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/domain/models/request/review_request.dart';

abstract class ReviewRepository {
  Future<bool> addReview(ReviewRequest request);
}

class ReviewRepositoryImpl implements ReviewRepository {
  final RemoteDataSource remote;

  ReviewRepositoryImpl({
    required this.remote
  });

  @override
  Future<bool> addReview(ReviewRequest request) async {
    try {
      final json = await remote.request(ApiRequest.addReview, null, request.payload(), null);
      final bool isSuccess = !json['error'];
      return isSuccess;
    } catch(e) {
      log(e.toString());
      throw Exception('Error in adding request: $e');
    }
  }
}