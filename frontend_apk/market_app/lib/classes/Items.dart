class Item {
  int? iId;
  String? itemName;
  String? category;
  int? quantity;
  String? lastModified;
  bool aboutToDelete = false;

  Item(
      {this.iId,
      this.itemName,
      this.category,
      this.quantity,
      this.lastModified,
      required this.aboutToDelete});

  Item.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    itemName = json['item_name'];
    category = json['category'];
    quantity = json['quantity'];
    lastModified = json['lastModified'];
    aboutToDelete = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['item_name'] = this.itemName;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['lastModified'] = this.lastModified;
    return data;
  }
}
