// import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/Theme/theme_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_cubit.dart';
import 'package:mouvour_flutter/presentation/pages/Details/details_page.dart';
import 'package:mouvour_flutter/presentation/pages/Discover/discover_page.dart';
import 'package:mouvour_flutter/presentation/pages/Explore/explore_page.dart';
import 'package:mouvour_flutter/presentation/pages/HomePage/home_page.dart';
import 'package:mouvour_flutter/presentation/pages/LikedMoviesPage/liked_movies_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ThemeCubit(),
    ),
  ], child: MyApp()));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) =>
          // BlocProvider(create: (context) => MovieCubit(), child: HomePage()),
          MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => MovieCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ], child: HomePage()),
      routes: <RouteBase>[
        GoRoute(
          path: 'likedMovies',
          name: 'likedMovies',
          builder: (BuildContext context, GoRouterState state) =>
              LikedMoviesPage(),
        ),
        GoRoute(
          path: 'explore',
          name: 'explore',
          builder: (BuildContext context, GoRouterState state) => ExplorePage(),
        ),
        GoRoute(
          path: 'discover',
          name: 'discover',
          builder: (BuildContext context, GoRouterState state) =>
              DiscoverPage(),
        ),
        GoRoute(
          path: 'details/:id',
          name: 'details',
          builder: (BuildContext context, GoRouterState state) =>
              MultiBlocProvider(
                  providers: [
                BlocProvider(
                  create: (context) => ThemeCubit(),
                  lazy: false,
                )
              ],
                  child: DetailsPage(
                    id: state.params['id'],
                    isDark: state.queryParams['isDark']
                    ,
                  )),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: theme.isDark ? ThemeData.dark() : ThemeData.light(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
