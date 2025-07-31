import 'dart:io';
import 'package:mstore/features/review/domain/models/review_body.dart';
import 'package:mstore/interface/repo_interface.dart';

abstract class ReviewRepositoryInterface
    implements RepositoryInterface<ReviewBody> {
  Future<dynamic> submitReview(
      ReviewBody reviewBody, List<File> files, bool update);

  Future<dynamic> getOrderWiseReview(String productID, String orderId);

  Future<dynamic> deleteOrderWiseReviewImage(String id, String name);
}
