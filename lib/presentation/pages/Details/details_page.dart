import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_state.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_state.dart';

class DetailsPage extends StatefulWidget {
  final String? id;
  const DetailsPage({super.key, @required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieLoadedState) {
            print(widget.id);
            var allData = [
              ...state.now_playing_movies!,
              ...state.popular_movies!,
              ...state.top_rated_movies!,
              ...state.trending_movies!
            ];
            // var now_movies = state.now_playing_movies
            //     ?.where((element) => element.id.toString() == widget.id)
            //     .toList();
            // var popMovies = state.popular_movies
            //     ?.where((element) => element.id.toString() == widget.id)
            //     .toList();
            // var topMov =
            //     state.top_rated_movies?.map((element) => element.id.toString() == widget.id).toList();
            // var trendMov =
            //     state.trending_movies?.map((element) => element.id.toString() == widget.id).toList();
            var filteredData = allData.firstWhere((element) => element.id.toString() == widget.id);
            
            print(" filteredData => $filteredData");

            var nm = filteredData;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 210,
                        child: Image.network(
                            "${Const.IMG}${nm.backdropPath ?? "nodata"}"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${nm.originalTitle ?? "no data title"}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("⭐ ${nm.voteAverage}/10 IMDb "),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      //genre
                      Row(
                          children: [1, 2].map((e) {
                                return Container(
                                  width: 65,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(206, 238, 204, 202),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "horror".toUpperCase(),
                                    style: TextStyle(fontSize: 12),
                                  )),
                                );
                              }).toList() ??
                              <Widget>[Text("no thisMovieData")]),
                      Divider(height: 25),
                      SizedBox(child: Text("${nm.overview ?? "no overview"}")),

                      SizedBox(
                        height: 20,
                      ),
                      //first-air-date
                      Text(
                        "releaseDate",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${nm.releaseDate ?? "no budget"}"),

                      SizedBox(
                        height: 20,
                      ),

                      //orignal languae
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Orignal Language  \n\n ${nm.originalLanguage ?? "originalLanguage empty"}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Casts",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: [1, 2, 3].map((e) {
                                  return Container(
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          maxRadius: 30,
                                          backgroundImage: NetworkImage(
                                              "https://images.unsplash.com/photo-1673261577380-f8b1bf214f6d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  );
                                }).toList() ??
                                <Widget>[Text("no casts")]),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Text("data");
        },
      ),
    );
  }
}
