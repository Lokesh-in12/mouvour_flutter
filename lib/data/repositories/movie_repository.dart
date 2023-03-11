import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/api/api.dart';

class MovieRepository {
  API api = API();

  Future<List<MovieModel>> fetchNowPlaying() async {
    try {
      print("in repo fetchNowPlaying");
      Response response = await api.sendRequest.get(
          "/movie/now_playing?api_key=${API.API_KEY}&language=en-US&page=1");
      List<dynamic> movieMaps = response.data['results'];
      print("movieMaps 78857==>>>>> $movieMaps");

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  //popular api
  Future<List<MovieModel>> fetchPopular() async {
    try {
      print("in repo fetchPopular");
      Response response = await api.sendRequest
          .get("/movie/popular?api_key=${API.API_KEY}&language=en-US&page=1");
      List<dynamic> movieMaps = response.data['results'];
      print("movieMaps 78857==>>>>> $movieMaps");

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  //toprated api
  Future<List<MovieModel>> fetchTopRated() async {
    try {
      print("in repo fetchTopRated");
      Response response = await api.sendRequest
          .get("/movie/top_rated?api_key=${API.API_KEY}&language=en-US&page=1");
      List<dynamic> movieMaps = response.data['results'];
      print("movieMaps 78857==>>>>> $movieMaps");

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  //treding api
  Future<List<MovieModel>> fetchTrending() async {
    try {
      print("in repo fetchTrending");
      Response response =
          await api.sendRequest.get("/trending/all/day?api_key=${API.API_KEY}");
      List<dynamic> movieMaps = response.data['results'];
      print("movieMaps 78857==>>>>> $movieMaps");

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  //get casta api
  Future<List<CastModel>> fetchCasts(String id) async {
    try {
      Response response = await api.sendRequest.get(
          "https://api.themoviedb.org/3/movie/$id/credits?api_key=${API.API_KEY}&language=en-US");
      List<dynamic> castMaps = response.data['cast'];

      return castMaps.map((movieMap) => CastModel.fromJson(movieMap)).toList();
    } catch (e) {
      throw (e);
    }
  }

  //fetchSingleMovieData
  Future<List<SingleMovieModel>> fetchSingleMovieData(String id) async {
    try {
      print("in repo FetchSingleMovieData and id => $id");
      Response response = await api.sendRequest
          .get("https://api.themoviedb.org/3/movie/$id?api_key=${API.API_KEY}");
      List<dynamic> singleMovieData = [response.data];
      print("singleMovieData ==>>>>> $singleMovieData");

      return singleMovieData
          .map((movieMap) => SingleMovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  //recommandations
  Future<List<MovieModel>> fetchRecommendedMovies(String id) async {
    try {
      print("in repo fetchRecommendedMovies and id => $id");
      Response response = await api.sendRequest.get(
          '/movie/$id/recommendations?api_key=${API.API_KEY}&language=en-US&page=1');
      List<dynamic> movieMaps = response.data['results'];

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  //similar
  Future<List<MovieModel>> fetchSimilarMovies(String id) async {
    try {
      print("in repo fetchsimilar and id => $id");
      Response response = await api.sendRequest.get(
          '/movie/$id/similar?api_key=${API.API_KEY}&language=en-US&page=1');
      List<dynamic> movieMaps = response.data['results'];

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }
}
