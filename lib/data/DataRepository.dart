import 'dart:convert';

import 'package:github_profile/data/models/Issues.dart';
import 'package:github_profile/data/models/UsersModels.dart';
import 'package:github_profile/data/models/Repositories.dart';
import 'package:http/http.dart';

class DataRepository {
  Future<Users> fetchUser(String input, int page) async {
    
    String api = 'https://api.github.com/search/users?q=$input&page=$page';
    
    print('api 1 : $api');
    
    return await get(api).then((data) {
      final jsonData = json.decode(data.body);

      if (jsonData['total_count'] == 0) {
        throw UserNotFoundException();
      } else {
        final alldata = Users.fromJson(json.decode(data.body));
        
        return alldata;
      }
    }).catchError((context) {
      throw UserNotFoundException();
    });
  }

  Future<Issues> fetchIssues(String input, int page) async {
    
    String api = 'https://api.github.com/search/issues?q=$input&page=$page';
    
    print(api);
    
    return await get(api).then((data) {
      final jsonData = json.decode(data.body);

      if (jsonData['total_count'] == 0) {
        throw UserNotFoundException();
      } else {
        final alldata = Issues.fromJson(json.decode(data.body));
        
        return alldata;
      }
    }).catchError((context) {
      throw UserNotFoundException();
    });
  }

  Future<Repositories> fetchRepositories(String input, int page) async {
    
    String api = 'https://api.github.com/search/repositories?q=$input&page=$page';
    
    print(api);
    
    return await get(api).then((data) {
      final jsonData = json.decode(data.body);

      if (jsonData['total_count'] == 0) {
        throw UserNotFoundException();
      } else {
        final alldata = Repositories.fromJson(json.decode(data.body));
        
        return alldata;
      }
    }).catchError((context) {
      throw UserNotFoundException();
    });
  }
}

class UserNotFoundException implements Exception {}
