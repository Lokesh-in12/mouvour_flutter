import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  static final API_KEY = "e458813ff8f9fd6ae8597fa989d111ef";

  Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = "https://api.themoviedb.org/3";
    // _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
