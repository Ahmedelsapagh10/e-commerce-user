import 'package:mstore/interface/repo_interface.dart';

abstract class BrandRepoInterface<T> implements RepositoryInterface {
  Future<dynamic> getSellerWiseBrandList(int sellerId);
}
