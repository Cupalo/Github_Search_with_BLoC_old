import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:github_profile/data/DataRepository.dart';
import 'package:github_profile/data/models/Issues.dart';
import 'package:github_profile/data/models/Repositories.dart';
import 'package:github_profile/data/models/UsersModels.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DataRepository _search;
  PostBloc(this._search) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    
    try {
      if (event is GetInput) {

        int next = 1;
        yield (PostLoading());

        if (event.radio =='users') {

          Users alldata;
          alldata = await _search.fetchUser(event.input, next);
          yield (PostLoadedUsers(alldata, false));
          
        } else if(event.radio == 'issues'){

          Issues alldata;
          alldata = await _search.fetchIssues(event.input, next);
          yield (PostLoadedIssues(alldata, false));
          
        } else {

          Repositories alldata;
          alldata = await _search.fetchRepositories(event.input, next);
          yield (PostLoadedRepositories(alldata, false));
        } 

      } else if (event is GetNext){

        print('LoadMore');

        if (event.radio =='users') {

          PostLoadedUsers postLoadedUsers = state as PostLoadedUsers;
          Users alldata;
          var next;

          if(postLoadedUsers.post.items.length%30==0){
            next = postLoadedUsers.post.items.length/30+1;
          }else{
            next = postLoadedUsers.post.items.length/30+2;
          }

          alldata = await _search.fetchUser(event.input, (next).toInt());
          print('panjang list 1 : ${postLoadedUsers.post.items.length}');
          postLoadedUsers.post.items.addAll(alldata.items);
          print('panjang list 2 : ${postLoadedUsers.post.items.length}');
          print('all data length 2 : ${alldata.items.length}');

          yield (postLoadedUsers.post.items.length >= postLoadedUsers.post.totalCount)
            ? postLoadedUsers.copyWith(true)
            : PostLoadedUsers(postLoadedUsers.post, false);

        } else if(event.radio == 'issues'){

          PostLoadedIssues postLoadedIssues = state as PostLoadedIssues;
          Issues alldata;
          var next;

          if(postLoadedIssues.post.items.length%30==0){
            next = postLoadedIssues.post.items.length/30+1;
          }else{
            next = postLoadedIssues.post.items.length/30+2;
          }

          alldata = await _search.fetchIssues(event.input, (next).toInt());
          print('panjang list 1 : ${postLoadedIssues.post.items.length}');
          postLoadedIssues.post.items.addAll(alldata.items);
          print('panjang list 2 : ${postLoadedIssues.post.items.length}');
          print('all data length 2 : ${alldata.items.length}');

          yield (postLoadedIssues.post.items.length>=postLoadedIssues.post.totalCount)
            ? postLoadedIssues.copyWith(true)
            : PostLoadedIssues(postLoadedIssues.post, false);
          
        } else {

          PostLoadedRepositories postLoadedRepositories = state as PostLoadedRepositories;
          Repositories alldata;
          var next;

          if(postLoadedRepositories.post.items.length%30==0){
            next = postLoadedRepositories.post.items.length/30+1;
          }else{
            next = postLoadedRepositories.post.items.length/30+2;
          }

          alldata = await _search.fetchRepositories(event.input, (next).toInt());
          print('panjang list 1 : ${postLoadedRepositories.post.items.length}');
          postLoadedRepositories.post.items.addAll(alldata.items);
          print('panjang list 2 : ${postLoadedRepositories.post.items.length}');
          print('all data length 2 : ${alldata.items.length}');
          
          yield (postLoadedRepositories.post.items.length>=postLoadedRepositories.post.totalCount)
            ? postLoadedRepositories.copyWith(true)
            : PostLoadedRepositories(postLoadedRepositories.post, false);

        }
      }
    } on UserNotFoundException {
      yield (PostError('This User was Not Found!'));
    
    }
  }
}


// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:github_profile/data/DataRepository.dart';
// import 'package:github_profile/data/models/UsersModels.dart';
// import 'package:meta/meta.dart';

// part 'post_event.dart';
// part 'post_state.dart';

// class PostBloc extends Bloc<PostEvent, PostState> {
//   final DataRepository _search;
//   PostBloc(this._search) : super(PostInitial());

//   @override
//   Stream<PostState> mapEventToState(PostEvent event) async* {
//     var alldata;

//     try {
//       if (event is GetInput) {
//         yield (PostLoading());
//         if (event.radio =='users') {
//           alldata = await _search.fetchUser(event.input);
//         } else if(event.radio == 'issues'){
//           alldata = await _search.fetchIssues(event.input);
//         } else {
//           alldata = await _search.fetchRepositories(event.input);
//         } 

//         yield (PostLoaded(alldata, false));

//       } else if (event is GetNext){
//         PostLoaded postLoaded = state as PostLoaded;
//         if (event.radio =='users') {
//           alldata = await _search.fetchUser(event.input);
//         } else if(event.radio == 'issues'){
//           alldata = await _search.fetchIssues(event.input);
//         } else {
//           alldata = await _search.fetchRepositories(event.input);
//         }
//         yield (alldata==null)
//           ? postLoaded.copyWith(alldata,true)
//           : PostLoaded(postLoaded.post + alldata, false);
//       }
//     } on UserNotFoundException {
//       yield (PostError('This User was Not Found!'));
    
//     }
//   }
// }
