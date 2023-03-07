import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/api/api.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_state.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_state.dart';
import 'package:mouvour_flutter/presentation/Widgets/movie_card_now.dart';

class DetailsPage extends StatefulWidget {
  final String? id;
  const DetailsPage({super.key, @required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<dynamic>? casts;
  List<dynamic>? recommended;
  List<dynamic>? fetched;

  MovieRepository movieRepository = MovieRepository();

  @override
  void initState() {
    super.initState();
    fetchThisMovieFromApi(widget.id ?? "78857");
    getCasts(widget.id ?? "78857");
    getRecommendations(widget.id ?? "78857");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void fetchThisMovieFromApi(String id) async {
    try {
      List<SingleMovieModel> data =
          await movieRepository.fetchSingleMovieData(id);
      setState(() {
        fetched = data;
      });
      print("fetched => $fetched");
    } catch (e) {
      print("line 52 $e");
    }
  }

  void getRecommendations(String id) async {
    print("get Recommanded");
    List<MovieModel> data =
        await movieRepository.fetchRecommendedMovies(widget.id ?? "1077280");
    print("recommended data => $data");
    setState(() {
      recommended = data;
    });
  }

  void getCasts(String id) async {
    try {
      List<CastModel> data =
          await movieRepository.fetchCasts(widget.id ?? "78857");
      var haveImgPath = data.where((e) => e.profilePath != null).toList();
      print(" filteredCasts => $haveImgPath ");
      setState(() {
        casts = haveImgPath;
      });
    } catch (e) {
      print("err in dets L-36 is $e");
    }
  }

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
            var movie = fetched?[0];
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: 210,
                              child: Image.network(
                                  "${Const.IMG}${movie?.backdropPath ?? "/rqbCbjB19amtOtFQbb3K2lgm2zv.jpg"}"),
                            ),
                            InkWell(
                              onTap: () => context.pop(),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${movie?.title ?? "no data title"}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                                "⭐ ${movie.voteAverage ?? "no rating"}/10 IMDb "),
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
                        SizedBox(
                            child: Text("${movie.overview ?? "no overview"}")),

                        SizedBox(
                          height: 20,
                        ),

                        //first-air-date and popularity

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Release Date",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("${movie.releaseDate ?? "no date"}"),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Popularity",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${movie.popularity ?? "no popularity"} %"),
                              ],
                            )
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //orignal languae
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Orignal Language ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                    "${movie.originalLanguage ?? "originalLanguage empty"}")
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Budget ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("${movie.budget ?? " empty"}")
                              ],
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
                              children: casts?.map((e) {
                                    return Container(
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            maxRadius: 30,
                                            backgroundImage: NetworkImage(
                                                "${Const.IMG}${e.profilePath}"),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList() ??
                                  <Widget>[Text("no casts")]),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recommended",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        //recomndations
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: recommended?.map((e) {
                                    return InkWell(
                                      onTap: () {
                                        context.pushNamed('details',
                                            params: {'id': "${e.id}"});
                                      },
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Movie_card_now(e: e),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList() ??
                                  <Widget>[Text("recommandaions")]),
                        ),
                      ],
                    ),
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
