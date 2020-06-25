import 'dart:async';

import 'package:goal_plan_tic_tac_toe/ai/Ai.dart';
import 'package:goal_plan_tic_tac_toe/ai/Utils.dart';
import 'package:goal_plan_tic_tac_toe/storage/game_info_repository.dart';

class GamePresenter {
  // callbacks into our UI
  void Function(int idx) showMoveOnUi;
  void Function(int winningPlayer) showGameEnd;

  GameInfoRepository _repository;
  Ai _aiPlayer;

  GamePresenter(this.showMoveOnUi, this.showGameEnd, this._repository) {
    _aiPlayer = Ai();
  }

  void onHumanPlayed(List<int> board) async {
    // evaluate the board after the human player
    int evaluation = Utils.evaluateBoard(board);
    if (evaluation != Ai.NO_WINNERS_YET) {
      onGameEnd(evaluation);
      return;
    }

    // calculate the next move, could be an expensive operation
    int aiMove = await Future(() => _aiPlayer.play(board, Ai.AI_PLAYER));

    Future.delayed(const Duration(seconds: 1), () {
      // do the next move
      board[aiMove] = Ai.AI_PLAYER;

      // evaluate the board after the AI player move
      evaluation = Utils.evaluateBoard(board);
      if (evaluation != Ai.NO_WINNERS_YET)
        onGameEnd(evaluation);
      else
        showMoveOnUi(aiMove);
    });
  }

  void onGameEnd(int winner) {
    _repository.addGamePlay();

    if (winner == Ai.HUMAN) {
      _repository.addVictory();
    } else if (winner == Ai.AI_PLAYER) {
      _repository.addLose();
    }

    showGameEnd(winner);
  }
}