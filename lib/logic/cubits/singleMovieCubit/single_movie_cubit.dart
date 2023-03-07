import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_state.dart';

class SingleMovieCubit extends Cubit<SingleMovieState> {
  SingleMovieCubit() : super(SingleMovieLoadingState()) {
    toRemoveFromLoadingState();
  }

  MovieRepository movieRepository = MovieRepository();

  void toRemoveFromLoadingState() {
    Future.delayed(Duration(hours:1 ));
    emit(SingleMovieLoadedState(ex: "emit"));
  }
}
