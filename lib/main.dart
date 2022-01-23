
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profile/bloc/RadioBloc.dart';
import 'package:github_profile/bloc/pagination_bloc.dart';
import 'package:github_profile/bloc/post_bloc.dart';
import 'package:github_profile/bloc/theme_bloc.dart';
import 'package:github_profile/data/DataRepository.dart';
import 'package:github_profile/pages/GitProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(DataRepository()),
          //child: GitProfile(),
        ),
        BlocProvider(
          create: (context)=> ThemeBloc(),
        ),
        BlocProvider(
          create: (context)=> RadioBloc(),
        ),
        BlocProvider(
          create: (context)=> PaginationBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state)=> MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: state ? dark : light,
          home: GitProfile(),
          ),
      ),
    );
  }
}
