import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore(ref.read(productHttpRepository).findAll());
});

// 페이지의 필요한 데이터만 관리함
// 한개 이상의 레파지토리를 조합해서 사용됨
class ProductListViewStore extends StateNotifier<List<Product>> {
  ProductListViewStore(super.state);

  void nfOnRefresh(List<Product> product) {
    state = product;
  }

  void npAddProduct(Product productRespDto) {
    // 무조건 깊은 복사로
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void npUpdateProduct(int id, Product productRespDto) {
    state = state.map((product) {
      if (product.id == id) {
        product.price = productRespDto.price;
        return product;
      } else {
        return product;
      }
    }).toList();
  }
}
