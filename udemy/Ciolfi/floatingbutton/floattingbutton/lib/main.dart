import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum operacao { create, show, hide, isShowing }

class _HomePageState extends State<HomePage> {

  int count = 0 ; 
  static const platform = const MethodChannel("android.channel.floating_window");

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((methodCall){
      if(methodCall.method == 'touch'){
        setState(() {
          count += 1; 
        });
      }
    });
    
    
  }  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Floating Button Demo"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("$count",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 50)),
              RaisedButton(
                child: Text("Create"),
                onPressed: () {
                  platform.invokeListMethod("create");
                },
              ),
              RaisedButton(
                child: Text("Show"),
                onPressed: () {
                  platform.invokeListMethod("show");
                },
              ),
              RaisedButton(
                child: Text("Hide"),
                onPressed: () {
                  platform.invokeListMethod("hide");
                },
              ),
              RaisedButton(
                child: Text("Verify"),
                onPressed: () {
                  platform.invokeMethod("isShowing").then((isShowing){
                    print(isShowing);
                  });
                },
              ),
            ],
          ),
        ));
  }
}