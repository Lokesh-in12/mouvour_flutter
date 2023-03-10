import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/logic/cubits/Theme/theme_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_state.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/singleMovieCubit/single_movie_state.dart';
import 'package:mouvour_flutter/presentation/Widgets/movie_card_now.dart';
import 'package:mouvour_flutter/presentation/Widgets/sidebyside_movie_card.dart';
import 'package:mouvour_flutter/routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    print("theme in home page = > ${theme.isDark}");
    return Scaffold(
      backgroundColor: theme.isDark ? Colors.grey[900] : Colors.grey[200],
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: Text("Mouvour ${theme.isDark ? "Dark mode" : "light Mode"}"),
        backgroundColor: theme.isDark
            ? Colors.grey[900]
            : Color.fromARGB(255, 104, 104, 104),
        // actions: <Widget>[
        //   ,
        //   SizedBox(
        //     width: 15,
        //   ),
        // ],
      ),
      drawer: Drawer(
        backgroundColor: theme.isDark ? Colors.black : Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        theme.changeTheme();
                      },
                      icon:
                          Icon(theme.isDark ? Icons.wb_sunny : Icons.dark_mode),
                      color: theme.isDark ? Colors.white : Colors.black),
                  Text(
                    "Switch to ${theme.isDark ? "light" : "dark"} mode",
                    style: TextStyle(
                        fontSize: 16,
                        color: theme.isDark ? Colors.white : Colors.black),
                  )
                ],
              ),
            ]),
          ),
        ),
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
                                .pushNamed('details', params: {
                              'id': '${e.id}',
                            }),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 210,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        // child: Image(
                                        //   image: NetworkImage(
                                        //       "${Const.IMG}${e.backdropPath}"),
                                        //   fit: BoxFit.cover,
                                        // ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${Const.IMG}${e.backdropPath}",
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 180,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.grey,
                                            )),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
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
                        height: 30,
                      ),
                      //now showing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Now showing",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    theme.isDark ? Colors.white : Colors.black),
                          ),
                          Text("See more",
                              style: TextStyle(
                                  color: theme.isDark
                                      ? Colors.white
                                      : Colors.black))
                        ],
                      ),

                      //movie_cards
                      SizedBox(
                        height: 20,
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

                                            context
                                                .pushNamed('details', params: {
                                              'id': "${e.id}",
                                            }, queryParams: {
                                              "isDark":
                                                  "${theme.isDark.toString()}"
                                            });
                                          },
                                          child: Container(
                                              child: Row(
                                            children: <Widget>[
                                              // movie_card_now(e),
                                              Movie_card_now(
                                                e: e,
                                                isDark: theme.isDark.toString(),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )));
                                    })
                                    // .take(2)
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
                                      fontSize: 20,
                                      color: theme.isDark.toString() == "true"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text("See more",
                                    style: TextStyle(
                                        color: theme.isDark.toString() == "true"
                                            ? Colors.white
                                            : Colors.black))
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
                                              child: SideBySideCard(
                                                e: e,
                                                isDark: theme.isDark,
                                              ));
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
                                      fontSize: 20,
                                      color: theme.isDark.toString() == "true"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text("See more",
                                    style: TextStyle(
                                        color: theme.isDark.toString() == "true"
                                            ? Colors.white
                                            : Colors.black))
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
                                              child: SideBySideCard(
                                                e: e,
                                                isDark: theme.isDark,
                                              ));
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
                            style: TextStyle(
                                fontSize: 20,
                                color: theme.isDark.toString() == "true"
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          Text("See more",
                              style: TextStyle(
                                  color: theme.isDark.toString() == "true"
                                      ? Colors.white
                                      : Colors.black))
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
                                          // child: Image(
                                          //   image: NetworkImage(
                                          //       Const.IMG + "${e.posterPath}"),
                                          //   height: 180,
                                          // ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${Const.IMG}${e.posterPath}",
                                            placeholder: (context, url) =>
                                                Center(
                                                    child:
                                                        CircularProgressIndicator(
                                              color: Colors.grey,
                                            )),
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
        color: theme.isDark.toString() == "true" ? Colors.black : Colors.white,
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
                    color: theme.isDark.toString() == "true"
                        ? Colors.white
                        : Colors.black,
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
}
