class Item {
  int? iId;
  String? itemName;
  String? category;
  int? quantity;
  String? lastModified;

  Item(
      {this.iId,
      this.itemName,
      this.category,
      this.quantity,
      this.lastModified});

  Item.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    itemName = json['item_name'];
    category = json['category'];
    quantity = json['quantity'];
    lastModified = json['lastModified'];
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
