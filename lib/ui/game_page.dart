import 'dart:math';
import 'package:flutter/material.dart';
import 'package:goal_plan_tic_tac_toe/ai/ai.dart';
import 'package:goal_plan_tic_tac_toe/storage/game_info_repository.dart';
import 'package:goal_plan_tic_tac_toe/ui/field.dart';
import 'package:goal_plan_tic_tac_toe/ui/game_presenter.dart';

class GamePage extends StatefulWidget {

  final String title;
  final GameInfoRepository repository;

  GamePage(this.title, this.repository);

  @override
  GamePageState createState() => GamePageState(repository);
}

class GamePageState extends State<GamePage> {

  List<int> board;
  int _currentPlayer;
  GameInfoRepository _repository;

  GamePresenter _presenter;

  GamePageState(this._repository) {
    this._presenter = GamePresenter(_movePlayed, _onGameEnd, _repository);
  }

  void _randomPlay() {
    var random = Random();
    bool randomPlayer = random.nextBool();

    // False mean AI will play first
    if (randomPlayer == false) {
      int min = 0;
      int max = 9;
      random = new Random();
      int r = min + random.nextInt(max - min);
      board[r] = Ai.AI_PLAYER;
    }
  }

  void _onGameEnd(int winner) {

    var title = "Game over!";
    var content = "You lose :(";
    switch(winner) {
      case Ai.HUMAN: // will never happen :)
        title = "Congratulations!";
        content = "You managed to beat an unbeatable AI!";
        break;
      case Ai.AI_PLAYER:
        title = "Game Over!";
        content = "You lose :(";
        break;
      default:
        title = "Draw!";
        content = "No winners here.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    setState(() {
                      reinitialize();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("Replay")),

                new FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
                child: Text("Stop"))
            ],
          );
    });
  }

  void _movePlayed(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      if (_currentPlayer == Ai.HUMAN) {
        _currentPlayer = Ai.AI_PLAYER;
        _presenter.onHumanPlayed(board);
      } else {
        _currentPlayer = Ai.HUMAN;
      }
    });
  }


  String getSymbolForIdx(int idx) {
    return Ai.SYMBOLS[board[idx]];
  }

  @override
  void initState() {
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    _currentPlayer = Ai.HUMAN;
    // generate the initial board
    board = List.generate(9, (idx) => 0);

    _randomPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(60),
            child: Text("You are playing as O", style: TextStyle(fontSize: 25),),
          ),
           Expanded(
             child: GridView.count(
                      crossAxisCount: 3,
                      // generate the widgets that will display the board
                      children: List.generate(9, (idx) {
                        return Field(idx: idx, onTap: _movePlayed, playerSymbol: getSymbolForIdx(idx));
                      }),
                  ),
              ),
        ],
      ),
    );
  }
}


