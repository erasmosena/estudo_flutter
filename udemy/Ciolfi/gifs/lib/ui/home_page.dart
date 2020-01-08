import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _limit = 19;
  int _offset = 0;
  String _key = "riHgesm84CeoIo5G4OpPA6VMVf4IIMJe";
  String _rating = "G";
  String _lang = "EN";

  bool get isBusca => _search != null ;
  @override
  void initState() {
    super.initState();
    _getGifs().then((data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Busca:",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _getGifs(),
                builder: (_, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(
                        height: 200,
                        width: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5,
                        ),
                      );
                      break;
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createGifTable(_, snapshot);
                  }
                }),
          ),
        ],
      ),
    );
  }

  _getGifs() async {
    print(" $_offset -> ${_offset+_limit}");
    http.Response response;
    if (_search == null) {
      String url =
          "https://api.giphy.com/v1/gifs/trending?api_key=$_key&limit=$_limit&rating=$_rating";
      response = await http.get(url);
    } else {
      String url =
          "https://api.giphy.com/v1/gifs/search?api_key=$_key&q=$_search&limit=$_limit&offset=$_offset&rating=$_rating&lang=$_lang";
      response = await http.get(url);
    }
    return json.decode(response.body);
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10,
      ),
      itemCount: !isBusca ? snapshot.data["data"].length:snapshot.data["data"].length+1 ,
      itemBuilder: (_, posicao) {
        bool ultimo = posicao >= snapshot.data["data"].length;
        if( !isBusca || !ultimo ){
          return GestureDetector(
            child: Image.network(
              snapshot.data["data"][posicao]["images"]["fixed_height"]["url"],
              height: 300,
              fit: BoxFit.cover,
            ),
          );
        }else{
           return Container(
             child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add,color: Colors.white,size: 70,),
                    Text(
                      "Carregar Mais ...",
                      style: TextStyle(color:Colors.white, fontSize: 22),)
                  ],
                  
                ),
                onTap: (){
                  setState(() {
                    _offset += _limit;
                  });
                },
              ),
           );
        }
      },
    );
  }
}
