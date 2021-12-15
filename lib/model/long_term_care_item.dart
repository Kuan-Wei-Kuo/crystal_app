class LongTermCareItem {
  String id;
  String name;
  int price;

  LongTermCareItem(this.id, this.name, this.price);

  factory LongTermCareItem.fromJson(Map<String, dynamic> parsedJson) {
    print(LongTermCareItem(parsedJson['id'].toString(),
        parsedJson['name'].toString(), parsedJson['price']));
    return LongTermCareItem(parsedJson['id'].toString(),
        parsedJson['name'].toString(), parsedJson['price']);
  }
}
