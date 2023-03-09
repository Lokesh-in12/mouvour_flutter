import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_state.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_state.dart';
import 'package:mouvour_flutter/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text("Mouvour"),
        backgroundColor: Colors.black,
        actions: const <Widget>[
          Icon(Icons.dark_mode),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {
          if (state is MovieLoadingState) {
            BlocProvider.of<MovieCubit>(context).fetchNowPlaying();
          }
        },
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MovieLoadedState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                width: double.infinity,
                // color: Colors.grey[400],
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          child: CarouselSlider(
                        items: state.now_playing_movies!.take(10).map((e) {
                          return InkWell(
                            onTap: () => GoRouter.of(context)
                                .pushNamed('details', params: {'id': '2'}),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 210,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: NetworkImage(
                                            "${Const.IMG}${e.backdropPath}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text("${e.title.toString()}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            pageViewKey: PageStorageKey(3),
                            viewportFraction: 1,
                            animateToClosest: true,
                            scrollPhysics: BouncingScrollPhysics(),
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            autoPlayInterval: Duration(seconds: 5)),
                      )),

                      SizedBox(
                        height: 20,
                      ),
                      //now showing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Now showing",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text("See more",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),

                      //movie_cards
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // color: Colors.red,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: state.now_playing_movies
                                    ?.map((e) {
                                      return InkWell(
                                          onTap: () async {
                                            // BlocProvider.of<SingleMovieCubit>(context)
                                            //     .emit(SingleMovieLoadingState("${e.id}"));
                                            // BlocProvider.of<SingleMovieCubit>(
                                            //         context)
                                            //     .SingleMovieData("${e.id}");

                                            context.pushNamed('details',
                                                params: {'id': "${e.id}"});
                                          },
                                          child: Container(
                                              child: Row(
                                            children: <Widget>[
                                              movie_card_now(e),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )));
                                    })
                                    .toList()
                                    .sublist(11, 18) ??
                                <Widget>[Text("no data")],
                          ),
                        ),
                      ),
                      //now showing movie cards ends here

                      SizedBox(
                        height: 20,
                      ),

                      //popular title
                      //scroll_perfect_layout
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Popular",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text("See more",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              child: Row(
                                children: state.popular_movies
                                        ?.map((e) {
                                          return InkWell(
                                              onTap: () async {
                                                context.pushNamed('details',
                                                    params: {'id': "${e.id}"});
                                              },
                                              child:
                                                  Side_by_side_movie_card(e));
                                        })
                                        .toList()
                                        .sublist(0, 5) ??
                                    <Widget>[Text("no data")],
                              ),
                            )
                          ],
                        ),
                      ),

                      // title for top-rated
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Top Rated",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text("See more",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              child: Row(
                                children: state.top_rated_movies
                                        ?.map((e) {
                                          return InkWell(
                                              onTap: () async {
                                                context.pushNamed('details',
                                                    params: {'id': "${e.id}"});
                                              },
                                              child:
                                                  Side_by_side_movie_card(e));
                                        })
                                        .toList()
                                        .sublist(0, 5) ??
                                    <Widget>[Text("no data")],
                              ),
                            )
                          ],
                        ),
                      ),
                      //trending now
                      // title for top-rated
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Trending Now",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text("See more",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        child: CarouselSlider(
                            carouselController: CarouselController(),
                            items: state.trending_movies
                                    ?.map((e) {
                                      return InkWell(
                                        onTap: () async {
                                          context.pushNamed('details',
                                              params: {'id': "${e.id}"});
                                        },
                                        child: Container(
                                          child: Image(
                                            image: NetworkImage(
                                                Const.IMG + "${e.posterPath}"),
                                            height: 180,
                                          ),
                                        ),
                                      );
                                    })
                                    .toList()
                                    .sublist(0, 5) ??
                                <Widget>[Text("no data")],
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: sqrt1_2)),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: Text("some eror"),
          );
        },
      ),
      //body ends here

      //bottom app bar start
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 55,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                  size: 25,
                ),
                onPressed: () => GoRouter.of(context).pushNamed('likedMovies'),
              ),
              CupertinoButton(
                  child: Icon(
                    Icons.explore_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                  onPressed: () => GoRouter.of(context).pushNamed('explore'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).pushNamed('discover'),
        child: Icon(CupertinoIcons.lightbulb_fill),
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container movie_card_now(e) {
    return Container(
      width: 140,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                image: NetworkImage(Const.IMG + "${e.posterPath}"),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            e.title.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "⭐ ${e.voteAverage.toString()}/10 IMDb",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Row Side_by_side_movie_card(e) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
            image: NetworkImage(Const.IMG + "${e.posterPath}"),
            height: 180,
          ),
        ),
        const SizedBox(
          width: 20.5,
        ),
        Container(
          // color: Colors.lightBlue,
          width: 222,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //title
              const SizedBox(
                height: 5,
              ),
              LimitedBox(
                maxWidth: 150,
                child: Text(
                  e.title.toString(),
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "⭐ ${e.voteAverage.toString()}/10 IMDb",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              //genres - of side movie cards
              SizedBox(
                height: 15,
              ),
              LimitedBox(
                maxWidth: 210,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 65,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(206, 238, 204, 202),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "horror".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
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
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
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
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),

              //time of a movie
              SizedBox(
                height: 10,
              ),
              Row(
                children: const <Widget>[
                  Icon(
                    Icons.timer_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  Text("1h 47m", style: TextStyle(color: Colors.white))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
