
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationBloc extends Cubit<bool>{
  PaginationBloc() : super(true);

  void changePagination()=> emit(!state);
  // void changeLazyLoad()=> emit(state==true);
  // void changeWithIndex()=> emit(state==false);
}