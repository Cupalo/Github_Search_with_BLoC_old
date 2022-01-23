class Issues {
  final int totalCount;
  final int incompleteResults;
  final List<Item> items;

  Issues({this.totalCount, this.incompleteResults, this.items});

  factory Issues.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> Items =
        list.map((i) => Item.fromJson(i)).toList();

    return Issues(
      totalCount: json['total_count'],
      incompleteResults: json['incompleteResults'],
      items: Items,
    );
  }
}

class Item {
  final String name;
  final UserIssues userIssues;
  final String title;
  final String updated_at;
  final String issues_state;

  Item(
      {this.name, this.userIssues, this.title, this.updated_at, this.issues_state});

  factory Item.fromJson(Map<String, dynamic> json) {
    
    var jsonUserIssues = json['user'];

    var objUserIssues = UserIssues.fromJson(jsonUserIssues);

    return Item(
      name: json['login'],
      userIssues: objUserIssues,
      title: json['title'],
      updated_at: json['updated_at'],
      issues_state: json['state']
    );
  }
}

class UserIssues {
  final String avatarUrl;

  UserIssues({this.avatarUrl});

  factory UserIssues.fromJson(Map<String, dynamic> json) {
    return UserIssues(
      avatarUrl: json['avatar_url'],
    );
  }
}