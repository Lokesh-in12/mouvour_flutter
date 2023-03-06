import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieLoadingState()) {
    fetchNowPlaying();
  }

  MovieRepository movieRepository = MovieRepository();

  void fetchNowPlaying() async {
    try {
      //now_playing
      List<MovieModel> nowMovies = await movieRepository.fetchNowPlaying();
      //popular
      List<MovieModel> popular_movies = await movieRepository.fetchPopular();

      //toprated
      List<MovieModel> top_rated = await movieRepository.fetchTopRated();

      //trending
      List<MovieModel> trending_movies = await movieRepository.fetchTrending();

      emit(MovieLoadedState(
        now_playing_movies: nowMovies,
        popular_movies: popular_movies,
        top_rated_movies: top_rated,
        trending_movies: trending_movies,
      ));
    } catch (e) {
      print("error is $e");
      emit(MovieErrorState(e.toString()));
    }
  }

  // //toprated
  // void fetchTopRated() async {
  //   try {
  //     print("in fetchTopRated()");
  //     List<MovieModel> top_rated = await movieRepository.fetchTopRated();
  //     print("after getting data and bfore emiiting $top_rated");
  //     emit(MovieLoadedState(top_rated_movies: top_rated));
  //     print("toprated $top_rated");
  //   } catch (e) {
  //     print("error is $e");
  //     emit(MovieErrorState(e.toString()));
  //   }
  // }

  // //trending
  // void fetchTrending() async {
  //   try {
  //     print("in fetchTrending()");
  //     List<MovieModel> trending_movies = await movieRepository.fetchTrending();
  //     print("after getting data and bfore emiiting $trending_movies");
  //     emit(MovieLoadedState(trending_movies: trending_movies));
  //     print("trending $trending_movies");
  //   } catch (e) {
  //     print("error is $e");
  //     emit(MovieErrorState(e.toString()));
  //   }
  // }
}
