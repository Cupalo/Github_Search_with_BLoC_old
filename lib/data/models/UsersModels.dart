//Users Models
class Users {
  final int totalCount;
  final int incompleteResults;
  final List<Item> items;

  Users({this.totalCount, this.incompleteResults, this.items});

  factory Users.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> Items =
        list.map((i) => Item.fromJson(i)).toList();

    return Users(
      totalCount: json['total_count'],
      incompleteResults: json['incompleteResults'],
      items: Items,
    );
  }
}

class Item {
  final String name;
  final String image;

  Item(
      {this.name, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['login'],
      image: json['avatar_url'],
    );
  }
}
