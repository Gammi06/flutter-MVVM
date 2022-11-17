class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  int id;
  String name;
  int price;

  // 이름이 있는 생성자
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
