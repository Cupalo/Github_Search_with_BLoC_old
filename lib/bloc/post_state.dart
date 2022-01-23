part of 'post_bloc.dart';

@immutable
abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostLoaded extends PostState {
  var post;
  bool hasReachedMax;
  PostLoaded(this.post, this.hasReachedMax);

  PostLoaded copyWith(var post, bool hasReachedMax){
    return PostLoaded(
      post ?? this.post, 
      hasReachedMax ?? this.hasReachedMax);
  }
}

class PostLoadedUsers extends PostState {
  Users post;
  bool hasReachedMax;
  PostLoadedUsers(this.post, this.hasReachedMax);

  PostLoadedUsers copyWith(bool hasReachedMax){
    return PostLoadedUsers(
      post ?? this.post, 
      hasReachedMax ?? this.hasReachedMax);
  }
}

class PostLoadedIssues extends PostState {
  Issues post;
  bool hasReachedMax;
  PostLoadedIssues(this.post, this.hasReachedMax);

  PostLoadedIssues copyWith(bool hasReachedMax){
    return PostLoadedIssues(
      post ?? this.post, 
      hasReachedMax ?? this.hasReachedMax);
  }
}

class PostLoadedRepositories extends PostState {
  Repositories post;
  bool hasReachedMax;
  PostLoadedRepositories(this.post, this.hasReachedMax);

  PostLoadedRepositories copyWith(bool hasReachedMax){
    return PostLoadedRepositories(
      post ?? this.post, 
      hasReachedMax ?? this.hasReachedMax);
  }
}

class PostError extends PostState {
  final String error;
  const PostError(this.error);
}
