import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/data/models/cast_model.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/data/models/sing/single_movie.dart';
import 'package:mouvour_flutter/data/repositories/movie_repository.dart';
import 'package:mouvour_flutter/logic/cubits/Theme/theme_cubit.dart';
import 'package:mouvour_flutter/presentation/Widgets/movie_card_now.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsPage extends StatefulWidget {
  final String? id;
  final String? isDark;
  DetailsPage({super.key, @required this.id, this.isDark});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // List<dynamic>? fetched;
  Stream? dataStream;

  StreamController _streamController = StreamController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieDets();
  }

  Future<void> getMovieDets() async {
    var movieDets = await movieRepository.fetchSingleMovieData(widget.id!);
    print("testing => ${movieDets[0]}");

    var castDets = await movieRepository.fetchCasts(widget.id!);
    print("testing => ${castDets[0]}");
    var similarDets = await movieRepository.fetchSimilarMovies(widget.id!);

    List allData = [
      [...movieDets],
      [...castDets],
      [...similarDets]
    ];
    debugPrint("All data is => ${allData}");
    _streamController.sink.add(allData);
    // _streamController.sink.add(allData);
    // dataStream = allData;
  }

  MovieRepository movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Some error occured"));
            } else {
              var movieData = snapshot.data![0][0];
              var castData = snapshot.data![1];
              var similarMov = snapshot.data![2] ?? ["no data"];
              return Scaffold(
                backgroundColor: widget.isDark.toString() == "true"
                    ? Colors.grey[900]
                    : Colors.grey[200],
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
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                "${Const.IMG}${movieData.backdropPath}",
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.grey)),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child: Icon(Icons.error)),
                                          )
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
                                        fontSize: 20,
                                        color: widget.isDark == "true"
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                                Text(
                                  "⭐ ${movieData?.voteAverage.toStringAsFixed(2) ?? "Unavailable"}/10 IMDb ",
                                  style: TextStyle(
                                      color: widget.isDark == "true"
                                          ? Colors.white
                                          : Colors.black),
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
                                      children:
                                          movieData?.genres.map<Widget>((e) {
                                    return Container(
                                      width: 81,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(206, 238, 204, 202),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            maxLines: 1,
                                            "${e.name.toString()}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black),
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
                              style: TextStyle(
                                  color: widget.isDark == "true"
                                      ? Colors.white
                                      : Colors.black),
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
                                          fontSize: 18,
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${movieData?.releaseDate ?? "Unavailable"}",
                                      style: TextStyle(
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Popularity",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${movieData?.popularity ?? "Unavailable"} %",
                                      style: TextStyle(
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
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
                                          fontSize: 18,
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      "${movieData?.originalLanguage ?? "Unavailable"}",
                                      style: TextStyle(
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Budget ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      "${movieData?.budget ?? " empty"} \$",
                                      style: TextStyle(
                                          color: widget.isDark == "true"
                                              ? Colors.white
                                              : Colors.black),
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
                                style: TextStyle(
                                    fontSize: 20,
                                    color: widget.isDark == "true"
                                        ? Colors.white
                                        : Colors.black),
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
                                                          color: widget
                                                                      .isDark ==
                                                                  "true"
                                                              ? Colors.white
                                                              : Colors.black)),
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
                                          style: TextStyle(
                                              color: widget.isDark == "true"
                                                  ? Colors.white
                                                  : Colors.black),
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
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: widget.isDark == "true"
                                          ? Colors.white
                                          : Colors.black),
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
                                          onTap: () async {
                                            context.pop();
                                            context
                                                .pushNamed('details', params: {
                                              'id': "${e.id}",
                                            }, queryParams: {
                                              "isDark":
                                                  "${widget.isDark.toString()}"
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Movie_card_now(
                                                    e: e,
                                                    isDark: widget.isDark),
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
                                          style: TextStyle(
                                              color: widget.isDark == "true"
                                                  ? Colors.white
                                                  : Colors.black),
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
            }
          }),
    );
  }
}
