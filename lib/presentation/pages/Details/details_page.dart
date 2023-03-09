import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/presentation/Widgets/movie_card_now.dart';

class DetailsPage extends StatelessWidget {
  final String? id;
  DetailsPage({super.key, @required this.id});

  // List<dynamic>? fetched;
  MovieRepository movieRepository = MovieRepository();

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

  // Future<List<MovieModel>?> getRecommendations(String id) async {
  //   try {
  //     print("get Recommanded id $id");
  //     List<MovieModel> data = await movieRepository.fetchRecommendedMovies(id);
  //     print("recommended data => $data");
  //     return data;
  //   } catch (e) {
  //     print("error at 64 dets => $e");
  //   }
  // }
  Future<List<MovieModel>?> getSimilarMovies(String id) async {
    try {
      print("get similar id $id");
      List<MovieModel> data = await movieRepository.fetchSimilarMovies(id);
      print("similar data => $data");
      return data;
    } catch (e) {
      print("error at 47 dets => $e");
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
      future: Future.wait(
          [fetchThisMovieFromApi(id!), getCasts(id!), getSimilarMovies(id!)]),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var movieData = snapshot.data![0][0];
          var castData = snapshot.data![1];
          var similarMov = snapshot.data![2];
          print("snapshot data is => ${snapshot.data![0][0].backdropPath}");
          return Scaffold(
            backgroundColor: Colors.grey[900],
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
                                child: movieData.backdropPath != null
                                    ? Image.network(
                                        "${Const.IMG}${movieData?.backdropPath}")
                                    : Text("Unavailable")),
                            InkWell(
                              onTap: () => context.pop(),
                              onLongPress: () => context.pushNamed('home'),
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
                            LimitedBox(
                              maxWidth: 180,
                              child: Text(
                                "${movieData?.title ?? "Unavailable"}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              "⭐ ${movieData?.voteAverage.toStringAsFixed(2) ?? "Unavailable"}/10 IMDb ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        //genre
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                                  children: movieData?.genres.map<Widget>((e) {
                                return Container(
                                  width: 81,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(206, 238, 204, 202),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        maxLines: 1,
                                        "${e.name.toString()}".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black),
                                      )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()) ??
                              Text("Unavailable"),
                        ),
                        Divider(height: 25),
                        SizedBox(
                            child: Text(
                          "${movieData?.overview ?? "Unavailable"}",
                          style: TextStyle(color: Colors.white),
                        )),

                        SizedBox(
                          height: 20,
                        ),

                        //first-air-date and popularity

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Release Date",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${movieData?.releaseDate ?? "Unavailable"}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Popularity",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${movieData?.popularity ?? "Unavailable"} %",
                                  style: TextStyle(color: Colors.white),
                                ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Orignal Language ",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "${movieData?.originalLanguage ?? "Unavailable"}",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Budget ",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "${movieData?.budget ?? " empty"} \$",
                                  style: TextStyle(color: Colors.white),
                                )
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
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                                          e.profilePath != null
                                              ? CircleAvatar(
                                                  maxRadius: 30,
                                                  backgroundImage: NetworkImage(
                                                      "${Const.IMG}${e.profilePath}"),
                                                )
                                              : Text("Unavailable",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList() ??
                                  <Widget>[
                                    Text(
                                      "Unavailable",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Similar Movies",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        //similar Movies
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: similarMov?.map<Widget>((e) {
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
                                  <Widget>[
                                    Text(
                                      "Similar movies Not Available",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]),
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
