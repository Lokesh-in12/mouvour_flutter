abstract class SingleMovieState {}

class SingleMovieLoadingState extends SingleMovieState {
  // final String id;
  // SingleMovieLoadingState(this.id);
}

class SingleMovieErrorState extends SingleMovieState {
  final String errMsg;
  SingleMovieErrorState(this.errMsg);
}

class SingleMovieLoadedState extends SingleMovieState {
  final String? ex;
  SingleMovieLoadedState({this.ex});
}
