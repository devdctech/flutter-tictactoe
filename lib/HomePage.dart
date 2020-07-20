import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer timeDelay;

  AssetImage cross = AssetImage('images/cross.png');
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage edit = AssetImage('images/edit.png');

  bool isCross = true;
  String message;
  List<String> gamestate;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.gamestate = [
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
      ];
      this.message = '';
    });
  }

  //TODO: Play game method
  playGame(int index) {
    setState(() {
      if (this.isCross) {
        this.gamestate[index] = 'Cross';
      } else {
        this.gamestate[index] = 'Circle';
      }
      this.isCross = !this.isCross;
      this.checkWin();
    });
  }

  //TODO: Reset game method
  resetGame() {
    setState(() {
      this.gamestate = [
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
      ];
      this.message = '';
    });
  }

  //TODO: Get Image method
  AssetImage getImage(String value) {
    switch (value) {
      case 'empty':
        return edit;
        break;
      case 'Circle':
        return circle;
        break;
      case 'Cross':
        return cross;
        break;
    }
  }

  //TODO: Check For The Win Logic
  checkWin() {
    if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[1]) &&
        (gamestate[1] == gamestate[2])) {
      setState(() {
        this.message = '${this.gamestate[0]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[3] != 'empty') &&
        (gamestate[3] == gamestate[4]) &&
        (gamestate[4] == gamestate[5])) {
      setState(() {
        this.message = '${this.gamestate[3]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[6] != 'empty') &&
        (gamestate[6] == gamestate[7]) &&
        (gamestate[7] == gamestate[8])) {
      setState(() {
        this.message = '${this.gamestate[6]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[3]) &&
        (gamestate[3] == gamestate[6])) {
      setState(() {
        this.message = '${this.gamestate[0]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[1] != 'empty') &&
        (gamestate[1] == gamestate[4]) &&
        (gamestate[4] == gamestate[7])) {
      setState(() {
        this.message = '${this.gamestate[1]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[2] != 'empty') &&
        (gamestate[2] == gamestate[5]) &&
        (gamestate[5] == gamestate[8])) {
      setState(() {
        this.message = '${this.gamestate[2]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[4]) &&
        (gamestate[4] == gamestate[8])) {
      setState(() {
        this.message = '${this.gamestate[0]} Wins!';
        return dialogBox();
      });
    } else if ((gamestate[2] != 'empty') &&
        (gamestate[2] == gamestate[4]) &&
        (gamestate[4] == gamestate[6])) {
      setState(() {
        this.message = '${this.gamestate[2]} Wins!';
        return dialogBox();
      });
    } else if (!gamestate.contains('empty')) {
      setState(() {
        this.message = 'Game Draw!';
        return dialogBox();
      });
    }
  }

  dialogBox() {
    timeDelay = Timer(Duration(seconds: 1), () {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                this.message,
                // textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Do You Want To Play Again?',
                style: TextStyle(
                  fontSize: 15.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )),
                FlatButton(
                    onPressed: () {
                      this.resetGame();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ))
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TicTacToe'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.red],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: this.gamestate.length,
                    itemBuilder: (context, i) => SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: OutlineButton(
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid),
                            onPressed: () {
                              if (gamestate[i] == 'empty') {
                                this.playGame(i);
                              }
                            },
                            child: Image(
                              image: getImage(this.gamestate[i]),
                            ),
                          ),
                        ))),
            Padding(
              padding: EdgeInsets.all(50.0),
              child: MaterialButton(
                  child: Text(
                    'Reset Game',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minWidth: 200.0,
                  height: 50.0,
                  elevation: 5.0,
                  color: Colors.orange,
                  onPressed: () {
                    this.resetGame();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
