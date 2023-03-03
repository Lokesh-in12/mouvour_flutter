import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Movies"),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lime,
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
            ],
          ),
        ),
      ),
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
