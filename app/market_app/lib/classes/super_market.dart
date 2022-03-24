class SuperMarket {
  final String SuperMarketName;
  final String Address;
  SuperMarket({required this.Address, required this.SuperMarketName});
  factory SuperMarket.fromJson(Map<String, dynamic> json) {
    return SuperMarket(
        SuperMarketName: json["super_market_name"], Address: json["address"]);
  }
}
