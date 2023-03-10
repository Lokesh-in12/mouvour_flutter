import 'package:flutter/material.dart';
import 'package:mouvour_flutter/data/consts/const.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          e.posterPath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  // child: Image(
                  //   image: NetworkImage("${Const.IMG}${e.posterPath}"),
                  // ))
                  child : CachedNetworkImage(
                    imageUrl: "${Const.IMG}${e.posterPath}",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.grey,)),
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                  ))
              : Text("Unavailable",style: TextStyle(color: Colors.white),),
          SizedBox(
            height: 10,
          ),
          e.title != null ? 
          LimitedBox(
            maxWidth: 30,
            
            child: Text(
              maxLines: 1,
              e.title.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            ),
          ) : Text("Unavailable",style: TextStyle(color: Colors.white)),
          SizedBox(
            height: 8,
          ),
          e.voteAverage != null ? 
          Text("⭐ ${e.voteAverage.toString()}/10 IMDb",style: TextStyle(color: Colors.white)) : Text("Unavailable",style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
