import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LikedMoviesPage extends StatelessWidget {
  const LikedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked Movies"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.lime,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
              movie_card_now(),
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
    height: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Positioned(child: CupertinoButton(child: Icon(CupertinoIcons.heart_fill,color: Colors.red,), onPressed: (){})),
        Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1677733866272-96cb6c2204ae?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
                )),
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
                size: 30,
              ),
            )
          ],
        ),

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
        Text("⭐ 9.1/10 IMDb"),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
