
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioBloc extends Bloc<String, String>{
  RadioBloc() : super('users');

  var _counter = 'users';
  
  @override
  Stream<String> mapEventToState(event) async* {
    if (event =='users') {
      _counter = 'users';
    } else if(event == 'issues'){
      _counter = 'issues';
    } else{
      _counter = 'repositories';
    }
    yield _counter;
    
    //throw UnimplementedError();
  }
  
}