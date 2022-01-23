part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetInput extends PostEvent {
  final String input;
  final String radio;
  GetInput(this.input, this.radio);
}

class GetNext extends PostEvent {
  final String input;
  final String radio;
  GetNext(this.input, this.radio);
}
