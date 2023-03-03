import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
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
      body: Padding(
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
                    // width: double.infinity,
                    // height: 190,
                    color: Colors.lightBlue,
                    child: CarouselSlider(
                      items: [1, 2, 3, 4].map((e) {
                        return Container(
                          color: Color.fromARGB(255, 2, 138, 21),
                          width: 250,
                          height: 150,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              "https://wallpapercave.com/wp/wp10388105.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          // autoPlay: true,
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
                      children: <Widget>[
                        movie_card_now(),
                        SizedBox(
                          width: 10,
                        ),
                        movie_card_now(),
                        SizedBox(
                          width: 10,
                        ),
                        movie_card_now(),
                        SizedBox(
                          width: 10,
                        ),
                        movie_card_now(),
                        SizedBox(
                          width: 10,
                        ),
                        movie_card_now(),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                //now showing movie cards ends here

                SizedBox(
                  height: 18,
                ),

                //popular title
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

                //side-by-side cards with info movie cards ==> popular
                const SizedBox(
                  height: 20,
                ),
                Container(
                    // color: Colors.orange,
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  child: Row(
                    children: <Widget>[
                      Side_by_side_movie_card(),
                      SizedBox(
                        height: 20,
                      ),
                      Side_by_side_movie_card(),
                      SizedBox(
                        height: 20,
                      ),
                      Side_by_side_movie_card(),
                      SizedBox(
                        height: 20,
                      ),
                      Side_by_side_movie_card(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),

                // title for top-rated
                SizedBox(
                  height: 25,
                ),
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
                  height: 30,
                ),

                //add here top rated
                Container(
                    width: double.infinity,
                    // color: Colors.orange,
                    child: Column(
                      children: <Widget>[
                        Side_by_side_movie_card(),
                        SizedBox(
                          height: 20,
                        ),
                        Side_by_side_movie_card(),
                        SizedBox(
                          height: 20,
                        ),
                        Side_by_side_movie_card(),
                        SizedBox(
                          height: 20,
                        ),
                        Side_by_side_movie_card(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )),

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
                      items: [1, 2, 3, 4, 5, 6].map((e) {
                        return Container(
                          child: Image.network(
                            "https://marketplace.canva.com/EAE_E8rjFrI/1/0/1131w/canva-minimal-mystery-of-forest-movie-poster-ggHwd_WiPcI.jpg",
                            height: 120,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: sqrt1_2)),
                )
              ],
            ),
          ),
        ),
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

              CupertinoButton(child: Icon(Icons.explore_outlined,color: Colors.black,size: 27,), onPressed: ()=>Navigator.pushNamed(context, Routes.explore)) 
             
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(CupertinoIcons.lightbulb_fill),
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container movie_card_now() {
    return Container(
      width: 140,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1677733866272-96cb6c2204ae?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
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

  Row Side_by_side_movie_card() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
            image: NetworkImage(
                "https://www.sonypictures.com/sites/default/files/styles/max_560x840/public/title-key-art/venomltbc_onesheet_1400x2100_est_0.jpg?itok=niH5C8AR"),
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
