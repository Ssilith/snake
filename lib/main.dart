import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake/button.dart';
import 'package:snake/tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'PressStart2P'),
      home: const MyHomePage(),
    );
  }
}

enum Directions { up, down, left, right }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numberOfSquares = 405;
  int numberOfSquaresInRow = 15;
  List<int> snake = [33, 48, 63, 78, 93];
  int randomNumber = 83;
  int counter = 0;
  late Timer timer;
  Directions direction = Directions.down;
  bool hasGameStarted = false;

  void startGame() {
    direction = Directions.down;
    snake = [33, 48, 63, 78, 93];
    counter = 0;
    randomNumber = 83;
    if (hasGameStarted) {
      setState(() {
        hasGameStarted = false;
      });
      timer.cancel();
    } else {
      hasGameStarted = true;
      timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        setState(() {
          moveSnake();
          getPoint();
          gameOver();
        });
      });
    }
  }

  void moveDown() {
    if (snake.last > numberOfSquares - numberOfSquaresInRow) {
      snake.add(snake.last + numberOfSquaresInRow - numberOfSquares);
    } else {
      snake.add(snake.last + numberOfSquaresInRow);
    }
  }

  void moveUp() {
    if (snake.last < numberOfSquaresInRow) {
      snake.add(snake.last - numberOfSquaresInRow + numberOfSquares);
    } else {
      snake.add(snake.last - numberOfSquaresInRow);
    }
  }

  void moveLeft() {
    if (snake.last % numberOfSquaresInRow == 0) {
      snake.add(snake.last + numberOfSquaresInRow - 1);
    } else {
      snake.add(snake.last - 1);
    }
  }

  void moveRight() {
    if (snake.last % numberOfSquaresInRow == numberOfSquaresInRow - 1) {
      snake.add(snake.last - numberOfSquaresInRow + 1);
    } else {
      snake.add(snake.last + 1);
    }
  }

  void getPoint() {
    if (snake.last == randomNumber) {
      generateFood();
      counter++;
    } else {
      snake.removeAt(0);
    }
  }

  void generateFood() {
    randomNumber = Random().nextInt(numberOfSquares);
    if (snake.contains(randomNumber)) {
      generateFood();
    }
  }

  void moveSnake() {
    switch (direction) {
      case Directions.up:
        moveUp();
        break;
      case Directions.down:
        moveDown();
        break;
      case Directions.left:
        moveLeft();
        break;
      case Directions.right:
        moveRight();
        break;
    }
  }

  void gameOver() {
    List<int> gameOverSnake = [...snake];
    gameOverSnake.removeLast();
    if (gameOverSnake.contains(snake.last)) {
      timer.cancel();
      hasGameStarted = false;
      direction = Directions.down;
      gameOverBaner();
    }
  }

  void gameOverBaner() {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.grey[900],
                  title: const Center(
                    child: Text('Game Over!',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Your score: $counter',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 5),
                      MyButton(
                          title: "Okay!",
                          onPressed: () => Navigator.of(context).pop()),
                    ],
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          final globalPosition = details.globalPosition;
          if (globalPosition.dx < size.width / 4) {
            if (direction != Directions.right) direction = Directions.left;
          } else if (globalPosition.dx > size.width * 3 / 4) {
            if (direction != Directions.left) direction = Directions.right;
          } else if (globalPosition.dy < size.height / 4) {
            if (direction != Directions.down) direction = Directions.up;
          } else if (globalPosition.dy > size.height * 3 / 4) {
            if (direction != Directions.up) direction = Directions.down;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: numberOfSquares,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 15),
                itemBuilder: (context, index) {
                  if (index == snake.last) {
                    return const Tile(color: Colors.red);
                  } else if (snake.contains(index)) {
                    return const Tile(color: Colors.white);
                  } else if (index == randomNumber) {
                    return const Tile(color: Colors.green);
                  } else {
                    return Tile(color: Colors.grey[900]);
                  }
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: size.width / 2 - 65),
                MyButton(
                    title: hasGameStarted ? "Stop!" : "Play!",
                    onPressed: () => startGame()),
                const Spacer(),
                Text("Score: ${counter.toString().padLeft(2)}",
                    style: const TextStyle(fontSize: 11, color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
