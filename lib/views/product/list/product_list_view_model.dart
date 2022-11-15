import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewModel =
    StateNotifierProvider<ProductListViewModel, List<Product>>((ref) {
  return ProductListViewModel();
});

// 페이지의 필요한 데이터만 관리함
// 한개 이상의 레파지토리를 조합해서 사용됨
class ProductListViewModel extends StateNotifier<List<Product>> {
  ProductListViewModel() : super([]);

  void onLoad(List<Product> product) {
    state = product;
  }
}
