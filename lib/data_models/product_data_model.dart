class ProductDataModel {
  String? name;
  String? description;
  double? price;
  String? image;

  ProductDataModel({
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory ProductDataModel.fromMapJson(Map<String, dynamic> map) {
    return ProductDataModel(
        name: map['title'],
        image: map['image'],
        price: map['price'],
        description: map['description']);
  }
}
