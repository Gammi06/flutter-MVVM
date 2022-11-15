import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// new를 직접 해주면 위험하기 때문에
// provider가 컨트롤러를 쥐고 있게끔 코딩할것 (읽기전용)
final productController = Provider((ref) {
  return ProductController();
});

// view -> controller 요청
// 컨트롤러는 뷰모델에 의존한다
class ProductController {
  ProductHttpRepository repo = ProductHttpRepository();

  void findAll() {
    List<Product> productList = repo.findAll();
    // provider가 가진 창고에 쏘옥 넣어주면 됨
    // => view는 provider의 창고만 보고 있으면 됨
  }

  void findById(int id) {}
  void insert() {}
  void updateById(int id) {}
  void deleteById(int id) {}
}
