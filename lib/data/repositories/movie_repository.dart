import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
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
      Response response = await api.sendRequest
          .get("/trending/all/day?api_key=${API.API_KEY}");
      List<dynamic> movieMaps = response.data['results'];
      print("movieMaps 78857==>>>>> $movieMaps");

      return movieMaps
          .map((movieMap) => MovieModel.fromJson(movieMap))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

}
