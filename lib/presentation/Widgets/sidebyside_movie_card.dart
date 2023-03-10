import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mouvour_flutter/data/consts/const.dart';

class SideBySideCard extends StatelessWidget {
  dynamic e;
  dynamic isDark;
  SideBySideCard({super.key, this.e, this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          // child: Image(
          //   image: NetworkImage(Const.IMG + "${e.posterPath}"),
          //   height: 180,
          // ),
          child: CachedNetworkImage(
            height: 210,
            imageUrl: "${Const.IMG}${e.posterPath}",
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
              color: isDark
                  ? isDark
                      ? Colors.white
                      : Colors.black
                  : Colors.black,
            )),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
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
                  style: TextStyle(
                      fontSize: 19,
                      color: isDark ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "⭐ ${e.voteAverage.toString()}/10 IMDb",
                style: TextStyle(
                    fontSize: 16, color: isDark ? Colors.white : Colors.black),
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
                children: <Widget>[
                  Icon(
                    Icons.timer_outlined,
                    size: 20,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  Text("1h 47m",
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
