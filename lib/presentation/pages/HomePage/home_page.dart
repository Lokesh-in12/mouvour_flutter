import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:mouvour_flutter/data/models/movies_model.dart';
import 'package:mouvour_flutter/logic/cubits/movie_cubit.dart';
import 'package:mouvour_flutter/logic/cubits/movie_state.dart';
import 'package:mouvour_flutter/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text("Mouvour"),
        actions: const <Widget>[
          Icon(Icons.dark_mode),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MovieLoadedState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Container(
                width: double.infinity,
                // color: Colors.grey[400],
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //now showing
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // width: double.infinity,
                          // height: 190,
                          // color: Colors.lightBlue,
                          child: CarouselSlider(
                        items: [1, 2, 3, 4].map((e) {
                          return Container(
                            width: 250,
                            height: 150,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(
                                      "https://wallpapercave.com/wp/wp10388105.jpg"),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            enableInfiniteScroll: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            autoPlayInterval: Duration(seconds: 5)),
                      )),

                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Now showing",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("See more")
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
                            children: state.now_playing_movies?.map((e) {
                                  return movie_card_now(e);
                                }).toList() ??
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
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text("See more")
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              child: Row(
                                children: state.popular_movies?.map((e) {
                                      return Side_by_side_movie_card(e);
                                    }).toList() ??
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
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text("See more")
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              child: Row(
                                children: state.top_rated_movies?.map((e) {
                                      return Side_by_side_movie_card(e);
                                    }).toList() ??
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
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("See more")
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        child: CarouselSlider(
                            carouselController: CarouselController(),
                            items: state.trending_movies?.map((e) {
                                  return Container(
                                    child: Image(
                                      image: NetworkImage(
                                          Const.IMG + "${e.posterPath}"),
                                      height: 180,
                                    ),
                                  );
                                }).toList() ??
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
                onPressed: () => Navigator.pushNamed(context, Routes.likedPage),
              ),
              CupertinoButton(
                  child: Icon(
                    Icons.explore_outlined,
                    color: Colors.black,
                    size: 27,
                  ),
                  onPressed: () => Navigator.pushNamed(context, Routes.explore))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.discover),
        child: Icon(CupertinoIcons.lightbulb_fill),
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container movie_card_now(e) {
    print(Const.IMG);
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
            "Spiderman: No Way Home",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("⭐ 9.1/10 IMDb")
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
              const LimitedBox(
                maxWidth: 150,
                child: Text(
                  "Venom Let There Be \n Carnage",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "⭐ 9.1/10 IMDb",
                style: TextStyle(fontSize: 16),
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
                  ),
                  Text("1h 47m")
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
