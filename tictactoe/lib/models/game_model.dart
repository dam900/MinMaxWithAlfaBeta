class Game {
  final int axisLen;
  final int winLimitNumber;
  final List<List<String>> _gameBoard = [];

  static Game? _game;
  factory Game({int axisLen = 3, int winLimitNumber = 3}) {
    return _game ??=
        Game._internal(axisLen: axisLen, winLimitNumber: winLimitNumber);
  }

  Game._internal({required this.axisLen, required this.winLimitNumber}) {
    for (int i = 0; i < axisLen; i++) {
      _gameBoard.add(List.filled(axisLen, ' '));
    }
  }

  List<String> get gameBoard {
    var spreadGameBoard = <String>[];
    for (final sublist in _gameBoard) {
      spreadGameBoard.addAll(sublist);
    }
    return spreadGameBoard;
  }

  void clearGameBoard() {
    for (int i = 0; i < axisLen; i++) {
      _gameBoard[i] = List.filled(axisLen, ' ');
    }
  }

  void put(String player, int position) {
    _gameBoard[position ~/ axisLen][position % axisLen] = player;
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
        if (_gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_gameBoard[i][j] == _gameBoard[i][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _gameBoard[i][j];
        }
      }
    }
    return ' ';
  }

  String checkRows() {
    for (int i = 0; i <= axisLen - winLimitNumber; i++) {
      for (int j = 0; j < axisLen; j++) {
        if (_gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_gameBoard[i][j] == _gameBoard[i + k][j]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _gameBoard[i][j];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopLeftBottomRight() {
    for (int i = 0; i <= axisLen - winLimitNumber; i++) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (_gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_gameBoard[i][j] == _gameBoard[i + k][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _gameBoard[i][j];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopRightBottomLeft() {
    for (int i = axisLen - 1; i >= axisLen - winLimitNumber; i--) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (_gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (_gameBoard[i][j] == _gameBoard[i - k][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return _gameBoard[i][j];
        }
      }
    }

    return ' ';
  }
}
