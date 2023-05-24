import 'dart:math';

import 'package:tictactoe/models/game_board_model.dart';

class Game {
  final int axisLen;
  final int winLimitNumber;
  final GameBoard _gameBoard;

  static Game? _game;
  factory Game({int axisLen = 3, int winLimitNumber = 3}) {
    return _game ??=
        Game._internal(axisLen: axisLen, winLimitNumber: winLimitNumber);
  }

  Game._internal({required this.axisLen, required this.winLimitNumber})
      : _gameBoard =
            GameBoard.empty(axisLen: axisLen, winLimitNumber: winLimitNumber);

  List<String> get spreadGameBoard {
    return _gameBoard.spreadGameBoard;
  }

  GameBoard get gameBoard => _gameBoard;

  GameBoard get board {
    return _gameBoard;
  }

  void clearGameBoard() {
    _gameBoard.clear();
  }

  void putFromIndex(String player, int position) {
    _gameBoard.gameBoard[position ~/ axisLen][position % axisLen] = player;
  }

  void putFromPoint(String player, Point point) {
    _gameBoard.gameBoard[point.x.toInt()][point.y.toInt()] = player;
  }

  String findWinner() {
    String colsResult = _gameBoard.checkColsForWinner();
    if (colsResult != ' ') {
      return colsResult;
    }
    String rowsResult = _gameBoard.checkRowsForWinner();
    if (rowsResult != ' ') {
      return rowsResult;
    }
    String diagonalsResultTopLeft = _gameBoard.checkDiagonalsTopLeftForWinner();
    if (diagonalsResultTopLeft != ' ') {
      return diagonalsResultTopLeft;
    }
    String diagonalsResultTopRight =
        _gameBoard.checkDiagonalsTopRightForWinner();
    if (diagonalsResultTopRight != ' ') {
      return diagonalsResultTopRight;
    }
    return ' ';
  }
}
