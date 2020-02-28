import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon:AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    else {
      return FutureBuilder<List>(
        future: suggestions(query),
  //      initialData: InitialData,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                var item = snapshot.data[index];
                return ListTile(
                  title: Text(item),
                  leading: Icon(Icons.play_arrow),
                  onTap: (){
                    close(context, item);
                  },
                );
              }
            );
          }
        },
      );
    }
  }

  Future<List> suggestions(String search)async {
    Response response = 
      await get("http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json");
      if(response.statusCode == 200){
        return json.decode(response.body)[1].map((v){
          return v[0];
        }).toList();
      }else{
        throw Exception("Failed to load suggestions");
      } 
  }

}