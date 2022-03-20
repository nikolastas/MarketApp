class Item {
  final String name;
  final int quantity;
  final String category;
  final id;
  bool value;
  Item(
      {required this.id,
      required this.name,
      required this.category,
      required this.quantity,
      required this.value});
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['_id'],
        name: json['item_name'],
        category: json['category'],
        quantity: json['quantity'],
        value: false);
  }
}
