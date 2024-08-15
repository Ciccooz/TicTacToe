import 'package:flutter/material.dart';
import 'game.dart';

void main() => runApp(MyApp());

Color dGrey   = Colors.grey[900];
Color grey    = Colors.grey[500];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //PLAY.........
  Widget play() {
    return Container(
      child: MaterialButton(
        child: Text(
          "Play",
          style: TextStyle(color: Colors.black, fontSize: 25)
        ),

        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25)
        ),

        color: grey,
        height: 50,
        minWidth: 125,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Game()),
          );
        },
      ),
      alignment: Alignment(0, 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: play(),
      backgroundColor: dGrey,
    );
  }
}
