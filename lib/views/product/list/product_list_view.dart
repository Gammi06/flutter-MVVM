import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pm = ref.watch(productListViewStore); // view모델을 바라봄
    final pc = ref.read(productController);
    final pl = ref.listen(productHttpRepository, (previous, next) {}); // 리빌드 X

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pc.insert(Product(4, '호박', 20000));
          showCupertinoDialog(
            context: context,
            builder: (context) => MyAlertDialog(msg: "생성 완료"),
          );
        },
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          // key = id값
          key: ValueKey(pm[index].id),
          onTap: () {
            pc.deleteById(pm[index].id);
            // if (pm[index].id == 4) {
            //   showCupertinoDialog(
            //     context: context,
            //     builder: (context) => MyAlertDialog(msg: "삭제 실패"),
            //   );
            // }
          },
          onLongPress: () {
            pc.updateById(pm[index].id, Product(99, 'test', 60000));
          },
          leading: Icon(Icons.wallet_travel),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      ),
    );
  }
}
