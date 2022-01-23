import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<bool>{
  ThemeBloc() : super(false);
  
  void changetheme()=> emit(!state);
}