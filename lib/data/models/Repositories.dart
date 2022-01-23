class Repositories {
  final int totalCount;
  final int incompleteResults;
  final List<Item> items;

  Repositories({this.totalCount, this.incompleteResults, this.items});

  factory Repositories.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> Items =
        list.map((i) => Item.fromJson(i)).toList();

    return Repositories(
      totalCount: json['total_count'],
      incompleteResults: json['incompleteResults'],
      items: Items,
    );
  }
}

class Item {
  final String fullName;
  final String description;
  final String createdAt;
  final Owner owner;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;

  Item(
      {this.fullName, this.description, this.createdAt,this.owner, this.stargazersCount, this.watchersCount, this.forksCount});

  factory Item.fromJson(Map<String, dynamic> json) {
    var jsonOwner = json['owner'];

    var objOwner = Owner.fromJson(jsonOwner);

    return Item(
      fullName: json['full_name'],
      description: json['description'],
      createdAt: json['created_at'],
      owner: objOwner,
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      forksCount: json['forks_count']
    );
  }
}

class Owner {
  final String avatarUrl;

  Owner({this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      avatarUrl: json['avatar_url'],
    );
  }
}