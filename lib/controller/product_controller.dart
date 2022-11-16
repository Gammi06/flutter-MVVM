import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// new를 직접 해주면 위험하기 때문에
// provider가 컨트롤러를 쥐고 있게끔 코딩할것 (읽기전용)
final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});

/**
 * 컨트롤러: 비지니스 로직 담당
 * 컨트롤러는 view를 참조하면 안된다
 */
// view -> controller 요청
// 컨트롤러는 뷰모델에 의존한다
class ProductController {
  // 뷰를 참조하고 싶을 때 (글로벌하게 의존함)
  final context = navigatorKey.currentContext!; // ! < 절대 null이 아님
  final Ref _ref;
  ProductController(this._ref);

  void findAll() {
    //통신한 데이터를 넣음
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    _ref
        .read(productListViewStore.notifier)
        .nfOnRefresh(productList); // 받아온 값을 뷰모델에 넣고 데이터갱신
    // => view는 viewmodel만 보고있으면 됨
  }

  void findById(int id) {}

  void insert(Product productReqDto) {
    Product productRespDto =
        _ref.read(productHttpRepository).insert(productReqDto);
    _ref.read(productListViewStore.notifier).npAddProduct(productRespDto);
  }

  void updateById(int id, Product productReqDto) {
    Product productRespDto =
        _ref.read(productHttpRepository).updateById(id, productReqDto);
    _ref
        .read(productListViewStore.notifier)
        .npUpdateProduct(id, productRespDto);
  }

  void deleteById(int id) {
    int result = _ref.read(productHttpRepository).deleteById(id);
    if (result == 1) {
      _ref.read(productListViewStore.notifier).removeProduct(id);
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => MyAlertDialog(msg: "삭제 실패"),
      );
    }
  }
}
