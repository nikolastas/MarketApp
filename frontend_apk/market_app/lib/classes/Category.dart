class Category {
  final String super_category;
  final String name;
  Category({required this.super_category, required this.name});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(super_category: json["super_category"], name: json["name"]);
  }
}
