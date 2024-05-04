class SepatuModel {
  int id;
  String image;
  String name;
  String description;
  String price;
  String merk;
  String rilis;
  String material;
  String shop;
  bool isFavorite; // properti untuk menunjukkan apakah item favorit atau tidak

  SepatuModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.merk,
    required this.rilis,
    required this.material,
    required this.shop,
    this.isFavorite = false, // nilai default adalah false
  });

  factory SepatuModel.fromJson(Map<String, dynamic> json) {
    return SepatuModel(
      id: json['id'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      merk: json['merk'] as String,
      rilis: json['rilis'] as String,
      material: json['material'] as String,
      shop: json['shop'] as String,
    );
  }
}
