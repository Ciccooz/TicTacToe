import 'package:flutter/material.dart';
import 'main.dart';

void main() => runApp(Game());

bool xTurn = true;
List <String> text = ["", "", "", "", "", "", "", "", ""];
String txt = "";
bool win = false;
bool bDraw = false;

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(title: 'Game'),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //TURN
  Widget turn() {
    String turn = "";

    if(xTurn)
      turn = "O";
    else
      turn = "X"; 

    if(!win){
      if(xTurn)
        txt = "X Turn";
      else
        txt = "O Turn";

      if(bDraw)
        txt = "DRAW";
    }
    else
      txt = "$turn WON";

    return Container(
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 35,
          color: Colors.grey[200]
        )
      ),

      alignment: Alignment(0, -0.75),
    );
  }
  
  //BOARD.........
  Widget board() {
    double top    = -0.4;
    double mid    = 0;
    double bottom = 0.4;

    double left   = -0.85;
    double center = 0;
    double right  = 0.85;

    return Container(
      alignment: Alignment.center,

      child: Stack(
        children: <Widget>[
          hLine(0, 0.2),
          hLine(0, -0.2),
          vLine(0.4, 0),
          vLine(-0.4, 0),

          button(left, top, 0),              //top left
          button(left, mid, 1),              //mid left
          button(left, bottom, 2),           //bottom left

          button(center, top, 3),            //top center
          button(center, mid, 4),            //mid center
          button(center, bottom, 5),         //bottom center

          button(right, top, 6),             //top right
          button(right, mid, 7),             //mid right
          button(right, bottom, 8),          //bottom right
        ],
      )
    );
  }

  //HLINE...........................
  Widget hLine(double x, double y) {
    return Container(
      child: Divider(
        thickness: 5,
        color: grey,
      ),

      padding: EdgeInsets.all(40),
      alignment: Alignment(x, y),
    );
  }

  //VLINE...........................
  Widget vLine(double x, double y) {
    return Container(
      child: VerticalDivider(
        thickness: 5,
        color: grey,
      ),

      padding: EdgeInsets.fromLTRB(50, 175, 50, 175),
      alignment: Alignment(x, y),
    );
  }

  //BUTTON...................................
  Widget button(double x, double y, int id) {
    return Container(
      alignment: Alignment(x, y),
      
      
      child: FlatButton(
        child: inside(text[id]),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,

        onPressed: () {
          if(!check()){
            if(xTurn && text[id] == ""){
              text[id] = "X";
            }
          
            if(xTurn == false && text[id] == ""){
              text[id] = "O";
            }

            xTurn = !xTurn;
            setState(() {});  

            if(draw()){
              bDraw = true;
              setState(() {});
            }
          }

          if(check()){
            win = true;
            setState(() {});  
          }
        },
      )
    );
  }

  //CHECK.......
  bool check() {
    //x
    //vertical
    return text[0] == "X" && text[1] == "X" && text[2] == "X" ||
           text[3] == "X" && text[4] == "X" && text[5] == "X" ||
           text[6] == "X" && text[7] == "X" && text[8] == "X" ||

    //horizontal
           text[0] == "X" && text[3] == "X" && text[6] == "X" ||
           text[1] == "X" && text[4] == "X" && text[7] == "X" ||
           text[2] == "X" && text[5] == "X" && text[8] == "X" ||

    //diagonal
           text[0] == "X" && text[4] == "X" && text[8] == "X" ||
           text[2] == "X" && text[4] == "X" && text[6] == "X" ||

    //o
    //vertical
           text[0] == "O" && text[1] == "O" && text[2] == "O" ||
           text[3] == "O" && text[4] == "O" && text[5] == "O" ||
           text[6] == "O" && text[7] == "O" && text[8] == "O" ||

    //horizontal
           text[0] == "O" && text[3] == "O" && text[6] == "O" ||
           text[1] == "O" && text[4] == "O" && text[7] == "O" ||
           text[2] == "O" && text[5] == "O" && text[8] == "O" ||

    //diagonal
           text[0] == "O" && text[4] == "O" && text[8] == "O" ||
           text[2] == "O" && text[4] == "O" && text[6] == "O";
  }

  //DRAW.......
  bool draw() {
    int count = 0;

    for(int i = 0; i < 9; i++){
      if(text[i] != "")
        count++;
    }

    if(count == 9)
      return true;
    else
      return false;
  }

  //RESTART.......
  void reset() {
    text = ["", "", "", "", "", "", "", "", ""];
    xTurn = xTurn;
    win = false;
    bDraw = false;
    txt = "";
  }

  //RESTART.........
  Widget restart() {
    return Container(
      child: MaterialButton(
        child: Text(
          "Restart",
          style: TextStyle(color: Colors.black, fontSize: 25)
        ),

        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25)
        ),

        color: grey,
        height: 50,
        minWidth: 125,

        onPressed: () {
          reset();
          setState(() {});
        },
      ),

      alignment: Alignment(0, 0.75),
    );
  }

  //INSIDE....................
  Widget inside(String text) {
    return Container(
      height: 100,
      width: 100,

      child: Text(
        text,

        style: TextStyle(
          fontSize: 50,      
          height: 1.75,
          color: Colors.grey[200]
        ),

        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dGrey,

      body: Stack(
        children: <Widget>[
          turn(),
          board(),
          if(win || bDraw)
            restart()
        ],
      ),
    );
  }
}