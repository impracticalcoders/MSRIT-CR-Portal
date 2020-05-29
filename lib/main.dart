
import 'package:flutter/material.dart';
import 'package:crportal/services/authservice.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    
   
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MSRIT CR Portal',
      debugShowCheckedModeBanner: false,
     darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.deepOrange),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          subtitle2: TextStyle(fontFamily: 'Archia'),
          subtitle1: TextStyle(fontFamily: 'Archia'),
          bodyText1: TextStyle(fontFamily: 'Archia'),
          bodyText2: TextStyle(fontFamily: 'Archia'),
          button: TextStyle(fontFamily: 'Archia'),
          headline6: TextStyle(fontFamily: 'Archia'),
          headline5: TextStyle(fontFamily: 'Archia'),
          headline4: TextStyle(fontFamily: 'Archia'),
          headline3: TextStyle(fontFamily: 'Archia'),
          headline2: TextStyle(fontFamily: 'Archia'),
          overline: TextStyle(fontFamily: 'Archia'),
          caption: TextStyle(fontFamily: 'Archia'),
          headline1: TextStyle(fontFamily: 'Archia'), 
        ),
      ),
      home: AuthService().handleAuth(),
    );
  }
}
