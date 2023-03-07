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
  // List<dynamic>? fetched;

  MovieRepository movieRepository = MovieRepository();

  @override
  void initState() {
    print(widget.id);
    super.initState();

    // fetchThisMovieFromApi(widget.id!);

    // getCasts(widget.id!);
    // getRecommendations(widget.id!);
  }

  Future<List<SingleMovieModel>?> fetchThisMovieFromApi(String id) async {
    try {
      print("fetchThisMovieFromApi provided in api = > $id");
      List<SingleMovieModel> data =
          await movieRepository.fetchSingleMovieData(id);
      print("fetched => $data");
      return data;
    } catch (e) {
      print("line 52 $e");
      // return e;
    }
  }

  Future<List<MovieModel>?> getRecommendations(String id) async {
    try {
      print("get Recommanded id $id");
      List<MovieModel> data = await movieRepository.fetchRecommendedMovies(id);
      print("recommended data => $data");
      return data;
    } catch (e) {
      print("error at 64 dets => $e");
    }
  }

  Future<List<CastModel>?> getCasts(String id) async {
    try {
      print("getcasts api => $id");
      List<CastModel> data = await movieRepository.fetchCasts(id);
      var haveImgPath = data.where((e) => e.profilePath != null).toList();

      return haveImgPath;
    } catch (e) {
      print("err in dets L-36 is $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        fetchThisMovieFromApi(widget.id!),
        getCasts(widget.id!),
        getRecommendations(widget.id!)
      ]),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var movieData = snapshot.data![0][0];
          var castData = snapshot.data![1];
          var recommendedMov = snapshot.data![2];
          print("snapshot data is => ${snapshot.data![0][0].backdropPath}");
          return Scaffold(
            body: SafeArea(
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
                                  "${Const.IMG}${movieData?.backdropPath ?? "/rqbCbjB19amtOtFQbb3K2lgm2zv.jpg"}"),
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
                              "${movieData?.title ?? "no data title"}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                                "⭐ ${movieData?.voteAverage ?? "no rating"}/10 IMDb "),
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
                            child: Text(
                                "${movieData?.overview ?? "no overview"}")),

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
                                Text("${movieData?.releaseDate ?? "no date"}"),
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
                                    "${movieData?.popularity ?? "no popularity"} %"),
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
                                    "${movieData?.originalLanguage ?? "originalLanguage empty"}")
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Budget ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("${movieData?.budget ?? " empty"}")
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
                              children: castData?.map<Widget>((e) {
                                    return Container(
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            maxRadius: 30,
                                            backgroundImage: NetworkImage(
                                                "${Const.IMG}${e.profilePath ?? "/rqbCbjB19amtOtFQbb3K2lgm2zv.jpg"}"),
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
                              children: recommendedMov?.map<Widget>((e) {
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
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
