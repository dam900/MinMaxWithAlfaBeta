import 'dart:math';

import 'package:tictactoe/models/game_board_model.dart';

class AiWithAlfaBetaModel {
  static const _maxDepth = 5;
  static const _minStartScore = -10000;
  static const _maxStartScore = 10000;

  // invoke the min max algorithm for every possible move
  Point findTheBestMove(GameBoard gameBoard) {
    int bestScore = _minStartScore;
    Point bestMove = Point(0, 0);

    for (var row = 0; row < gameBoard.axisLen; row++) {
      for (var col = 0; col < gameBoard.axisLen; col++) {
        if (gameBoard.gameBoard[row][col] == ' ') {
          gameBoard.gameBoard[row][col] = 'O';
          int score = _minMaxWithAlfaBeta(
              gameBoard, _maxDepth, _minStartScore, _maxStartScore, false);
          gameBoard.gameBoard[row][col] = ' ';
          if (score > bestScore) {
            bestScore = score;
            bestMove = Point(row, col);
          }
        }
      }
    }

    return bestMove;
  }

  int _minMaxWithAlfaBeta(GameBoard gameBoard, int depth, int alpha, int beta,
      bool maximizingPlayer) {
    int score = _evaluate(gameBoard);

    // - and + depth for winning sonner or loosing later
    if (score == 10) {
      return score - depth;
    } else if (score == -10) {
      return score + depth;
    } else if (!gameBoard.isMoveAvaliable() || depth == 0) {
      return 0;
    }

    if (maximizingPlayer) {
      int bestScore = _minStartScore;
      for (var row = 0; row < gameBoard.axisLen; row++) {
        for (var col = 0; col < gameBoard.axisLen; col++) {
          if (gameBoard.gameBoard[row][col] == ' ') {
            gameBoard.gameBoard[row][col] = 'O';
            int score =
                _minMaxWithAlfaBeta(gameBoard, depth - 1, alpha, beta, false);
            gameBoard.gameBoard[row][col] = ' ';
            bestScore = score > bestScore ? score : bestScore;
            alpha = max(alpha, bestScore);
            if (alpha >= beta) {
              return bestScore;
            }
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = _maxStartScore;
      for (var row = 0; row < gameBoard.axisLen; row++) {
        for (var col = 0; col < gameBoard.axisLen; col++) {
          if (gameBoard.gameBoard[row][col] == ' ') {
            gameBoard.gameBoard[row][col] = 'X';
            int score =
                _minMaxWithAlfaBeta(gameBoard, depth - 1, alpha, beta, true);
            gameBoard.gameBoard[row][col] = ' ';
            bestScore = score < bestScore ? score : bestScore;
            beta = min(beta, bestScore);
            if (beta <= alpha) {
              return bestScore;
            }
          }
        }
      }
      return bestScore;
    }
  }

  int _evaluate(GameBoard gameBoard) {
    String colsWinner = gameBoard.checkColsForWinner();
    if (colsWinner == 'X') {
      return -10;
    } else if (colsWinner == 'O') {
      return 10;
    }
    String rowWinner = gameBoard.checkRowsForWinner();
    if (rowWinner == 'X') {
      return -10;
    } else if (rowWinner == 'O') {
      return 10;
    }
    String diagTopLeftWinner = gameBoard.checkDiagonalsTopLeftForWinner();
    if (diagTopLeftWinner == 'X') {
      return -10;
    } else if (diagTopLeftWinner == 'O') {
      return 10;
    }
    String diagTopRightWinner = gameBoard.checkDiagonalsTopRightForWinner();
    if (diagTopRightWinner == 'X') {
      return -10;
    } else if (diagTopRightWinner == 'O') {
      return 10;
    }

    return 0;
  }
}
