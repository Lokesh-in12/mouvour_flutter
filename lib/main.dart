// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/presentation/pages/Discover/discover_page.dart';
import 'package:mouvour_flutter/presentation/pages/Explore/explore_page.dart';
import 'package:mouvour_flutter/presentation/pages/HomePage/home_page.dart';
import 'package:mouvour_flutter/presentation/pages/LikedMoviesPage/liked_movies_page.dart';
import 'package:mouvour_flutter/routes/app_routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.home: (context) => BlocProvider(
              create: (context) => MovieCubit(),
              child: HomePage(),
            ),
        Routes.likedPage: (context) => LikedMoviesPage(),
        Routes.explore: (context) => ExplorePage(),
        Routes.discover: (context) => DiscoverPage(),
      },
    );
  }
}
