import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");

  bool isCross = true;
  String message;
  List<String> gameState;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = "cross";
        } else {
          this.gameState[index] = "circle";
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
    }
  }

  checkWin() {
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      // if any user Win update the message state
      setState(() {
        this.message = '${this.gameState[0]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        this.message = '${this.gameState[3]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[6]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        this.message = '${this.gameState[1]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw';
        Future.delayed(const Duration(seconds: 3))
            .then((value) => this.resetGame());
      });
    }
  }

  static Future<void> vibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(50.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 50.0),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(50.0),
            child: Text(
              this.message.toUpperCase(),
              style: TextStyle(
                color: Colors.red,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.black87,
            minWidth: 150.0,
            height: 50.0,
            splashColor: Colors.black,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              "Reset Game",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              this.resetGame();
              vibrate();
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "www.uditmaherwal.com",
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}
