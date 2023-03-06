import 'package:mouvour_flutter/data/models/movies_model.dart';

abstract class MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<dynamic>? now_playing_movies;
  final List<dynamic>? popular_movies;
  final List<dynamic>? top_rated_movies;
  final List<dynamic>? trending_movies;
  MovieLoadedState({
    this.now_playing_movies,
    this.popular_movies,
    this.top_rated_movies,
    this.trending_movies,
  });
}

class MovieErrorState extends MovieState {
  final String errMsg;
  MovieErrorState(this.errMsg);
}

class thisMovieState extends MovieState {
 
}
