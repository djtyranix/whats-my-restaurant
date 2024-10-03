import 'package:whats_on_restaurant/domain/models/request/review_request.dart';
import 'package:whats_on_restaurant/modules/review/repository/review_repository.dart';

abstract class ReviewInteractor {
  Future<bool> addReview(String id, String name, String review);
}

class ReviewInteractorImpl implements ReviewInteractor {
  final ReviewRepository repository;

  ReviewInteractorImpl({
    required this.repository
  });

  @override
  Future<bool> addReview(String id, String name, String review) async {
    try {
      final request = ReviewRequest(id: id, name: name, review: review);
      final data = await repository.addReview(request);
      return data;
    } catch(e) {
      throw Exception('Error getting data: $e');
    }
  }
}