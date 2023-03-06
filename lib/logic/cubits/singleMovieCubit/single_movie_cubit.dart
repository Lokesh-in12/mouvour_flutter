import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_state.dart';

class SingleMovieCubit extends Cubit<SingleMovieState> {
  SingleMovieCubit() : super(SingleMovieLoadingState()) {
    
  }

  MovieRepository movieRepository = MovieRepository();

  //fetch Single Movie Data
  void SingleMovieData(String id) async {
    try {
      print("in singleMovieData");
      //movieDesc
      List<SingleMovieModel> movieDesc =
          await movieRepository.fetchSingleMovieData(id);

      print("movieDesc => $movieDesc");

      //getCasts
      List<CastModel> casts = await movieRepository.fetchCasts(id);
      print("in single movieData movieDesc => $movieDesc and casts $casts");
      emit(SingleMovieLoadedState(movieDesc: movieDesc, casts: casts));
    } catch (e) {
      print("error is $e");
      emit(SingleMovieErrorState(e.toString()));
    }
  }
}
