import 'package:tictactoe/models/board_model.dart';

class Game {
  final int axisLen;
  final int winLimitNumber;
  final GameBoard _board;

  static Game? _game;
  factory Game({int axisLen = 3, int winLimitNumber = 3}) {
    return _game ??=
        Game._internal(axisLen: axisLen, winLimitNumber: winLimitNumber);
  }

  Game._internal({required this.axisLen, required this.winLimitNumber})
      : _board = GameBoard.empty(axisLen: axisLen);

  List<String> get gameBoard {
    return _board.spreadGameBoard;
  }

  GameBoard get board {
    return _board;
  }

  void clearGameBoard() {
    _board.clear();
  }

  void put(String player, int position) {
    _board.put(player, position);
  }

  String findWinner() {
    String colsResult = checkCols();
    if (colsResult != ' ') {
      return colsResult;
    }
    String rowsResult = checkRows();
    if (rowsResult != ' ') {
      return rowsResult;
    }
    String diagonalsResultTopLeft = checkDiagonalsTopLeftBottomRight();
    if (diagonalsResultTopLeft != ' ') {
      return diagonalsResultTopLeft;
    }
    String diagonalsResultTopRight = checkDiagonalsTopRightBottomLeft();
    if (diagonalsResultTopRight != ' ') {
      return diagonalsResultTopRight;
    }
    return ' ';
  }

  String checkCols() {
    for (int i = 0; i < axisLen; i++) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (_board.gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_board.gameBoard[i][j] == _board.gameBoard[i][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _board.gameBoard[i][j];
        }
      }
    }
    return ' ';
  }

  String checkRows() {
    for (int i = 0; i <= axisLen - winLimitNumber; i++) {
      for (int j = 0; j < axisLen; j++) {
        if (_board.gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_board.gameBoard[i][j] == _board.gameBoard[i + k][j]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _board.gameBoard[i][j];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopLeftBottomRight() {
    for (int i = 0; i <= axisLen - winLimitNumber; i++) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (_board.gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_board.gameBoard[i][j] == _board.gameBoard[i + k][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _board.gameBoard[i][j];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopRightBottomLeft() {
    for (int i = axisLen - 1; i >= axisLen - winLimitNumber; i--) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (_board.gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_board.gameBoard[i][j] == _board.gameBoard[i - k][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _board.gameBoard[i][j];
        }
      }
    }

    return ' ';
  }
}
