import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Movies"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Try these Movies",
                style: TextStyle(fontSize: 25, fontFamily: 'Montserrat'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // color: Colors.black,
                child: CarouselSlider(
                    carouselController: CarouselController(),
                    items: [1, 2, 3, 4, 5, 6].map((e) {
                      return Container(
                        child: Image.network(
                          "https://marketplace.canva.com/EAE_E8rjFrI/1/0/1131w/canva-minimal-mystery-of-forest-movie-poster-ggHwd_WiPcI.jpg",
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      // aspectRatio: 4/5
                    )),
              ),

              SizedBox(
                height: 30,
              ),

              //sections of movie geners
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Try out some geners",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              Section_of_movie_card("Action"),
              Section_of_movie_card("Horror"),
              Section_of_movie_card("Comedy"),
              Section_of_movie_card("Thriller"),
              Section_of_movie_card("Family"),

              // movie_card_now()
            ],
          ),
        )),
      ),
    );
  }

  Column Section_of_movie_card(title) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("See more")
                ],
              ),
              SizedBox(
                height: 20,
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
            ],
          ),
        )
      ],
    );
  }
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
