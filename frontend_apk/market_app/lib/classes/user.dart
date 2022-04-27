class User {
  String username;
  String email;
  String group;
  User({required this.username, required this.email, required this.group});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json["username"], email: json["email"], group: json["group"]);
  }
}
