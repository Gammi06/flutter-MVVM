// spring의 api문서를 확인하고 제작할 것
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository();
});

class ProductHttpRepository {
  //테스트용
  List<Product> list = [
    Product(1, "바나나", 1000),
    Product(2, "딸기", 2000),
    Product(3, "포도", 1500)
  ];

  Product findById(int id) {
    // http 통신 코드 (api문서 보고 작성하기)
    // 통신용 스레드를 만들어서 findById를 하게끔 구현해야 함
    // 메인 스레드는 통신을 시켜놓고 밑으로 내려 옴
    // 그래서 보통 통신을 할 때 약속이 담긴 Future<>를 리턴해서 (null을 가진 상자)
    // provider가 FutureBox에 값이 담기면 확인하고(Watch하고 있음) view를 리빌드 한다.
    Product product = list.singleWhere((product) => product.id == id);
    return product;
  }

  List<Product> findAll() {
    // http 통신 코드 (api문서 보고 작성하기)
    return list;
  }

  // name, price만 들어옴
  // 외부통신때 사용함
  Product insert(Product product) {
    // http 통신 코드 (api문서 보고 작성하기)
    product.id = 4;
    list = [...list, product];
    return product;
  }

  Product updateById(int id, Product productDto) {
    // http 통신 코드 (api문서 보고 작성하기)
    productDto.id = id;
    list = list.map((product) {
      if (product.id == id) {
        return productDto;
      } else {
        return product;
      }
    }).toList();
    return productDto;
  }

  int deleteById(int id) {
    // http 통신 코드 (api문서 보고 작성하기)
    list.where((product) => product.id != id).toList();
    if (id == 4) {
      return -1;
    } else {
      return 1;
    }
    return 1;
  }
}
