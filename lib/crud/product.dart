class Product {
  String _id;
  String _name, _description;

  Product(this._id, this._name, this._description);

  String get id => _id;
  String get name => _name;
  String get description => _description;

  set id(String id) {
    _id = id;
  }

  set name(String name) {
    _name = name;
  }

  set description(String description) {
    _description = description;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "name": _name,
      "description": _description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json["id"], json["name"], json["description"]);
  }
}
