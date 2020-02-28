import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorites_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/screens/Favorites.dart';
import 'package:fluttertube/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoritesBloc = BlocProvider.getBloc<FavoritesBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String,Video>>(
                stream: favoritesBloc.outFav,
                builder: (_, snapshot) {
                if (snapshot.hasData) 
                  return Text(snapshot.data.length.toString());
                else
                  return Text("0");
              })),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_)=>Favorites())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null)
                BlocProvider.getBloc<VideosBloc>()
                    .inSearchController
                    .add(result);
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (_, index) {
                  if (index < snapshot.data.length)
                    return VideoTile(snapshot.data[index]);
                  else if (index > 1) {
                    BlocProvider.getBloc<VideosBloc>()
                        .inSearchController
                        .add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else
                    return Container();
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
