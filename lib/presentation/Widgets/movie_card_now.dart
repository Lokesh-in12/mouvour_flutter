import 'package:flutter/material.dart';
import 'package:mouvour_flutter/data/consts/const.dart';

class Movie_card_now extends StatelessWidget {
  dynamic e;
  Movie_card_now({this.e});

  @override
  Widget build(BuildContext context) {
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
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("⭐ ${e.voteAverage.toString()}/10 IMDb")
        ],
      ),
    );
  }
}
