import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredash/wiredash.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/config/config.dart';
import 'package:xlo/screens/base/base_screen.dart';

import 'blocs/home_bloc.dart';

void main() => runApp(XloApp());

class XloApp extends StatefulWidget {
  @override
  _XloAppState createState() => _XloAppState();
}

class _XloAppState extends State<XloApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: wireDashKey,
      secret: wireDashSecret,
      //theme: WiredashThemeData(),
      navigatorKey: _navigatorKey,
      child: MultiProvider(
        providers: [
          Provider<DrawerBloc>(
            create: (_) => DrawerBloc(),
            dispose: (context, value) => value.dispose(),
          ),
          Provider<HomeBloc>(
            create: (_) => HomeBloc(),
            dispose: (context, value) => value.dispose(),
          )
        ],
        child: MaterialApp(

            title: 'XLO',
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BaseScreen()),
      ),
    );
  }
}
