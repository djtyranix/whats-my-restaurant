import 'package:whats_on_restaurant/domain/models/request/base_request.dart';

class ReviewRequest implements Request {
  final String id;
  final String name;
  final String review;

  ReviewRequest({
    required this.id,
    required this.name,
    required this.review
  });
  
  @override
  Map<String, dynamic> payload() {
    return {
      'id': this.id,
      'name': this.name,
      'review': this.review
    };
  }
}