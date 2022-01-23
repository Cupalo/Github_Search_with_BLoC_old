
import 'package:flutter/material.dart';
import 'package:github_profile/data/models/Issues.dart';
import 'package:github_profile/data/models/UsersModels.dart';
import 'package:github_profile/data/models/Repositories.dart';

ListTile buildUserData(Users users, int index) {
  return ListTile(
    leading: Image(image: NetworkImage(users.items.elementAt(index).image))?? Icon(Icons.people),
    title: Text(users.items.elementAt(index).name),
  );
}

ListTile buildIssuesData(Issues issues, int index) {
  return ListTile(
    leading: Image(image: NetworkImage(issues.items.elementAt(index).userIssues.avatarUrl))?? Icon(Icons.people),
    title: Text(issues.items.elementAt(index).title),
    subtitle: Text(issues.items.elementAt(index).updated_at),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(issues.items.elementAt(index).issues_state),
      ],
    ),
  );
}

ListTile buildRepositoryData(Repositories repos, int index) {
  return ListTile(
    leading: Image(image: NetworkImage(repos.items.elementAt(index).owner.avatarUrl))?? Icon(Icons.people),
    title: Text(repos.items.elementAt(index).fullName),
    subtitle: Text(repos.items.elementAt(index).createdAt),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(repos.items.elementAt(index).watchersCount.toString()),
        Text(repos.items.elementAt(index).stargazersCount.toString()),
        Text(repos.items.elementAt(index).forksCount.toString())
      ],
    ),
  );
}

