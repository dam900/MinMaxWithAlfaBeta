class GameBoard {
  late final List<List<String>> gameBoard = [];
  final int axisLen;
  final int winLimitNumber;

  GameBoard({required this.axisLen, required this.winLimitNumber});

  GameBoard.empty({required this.axisLen, required this.winLimitNumber}) {
    for (int i = 0; i < axisLen; i++) {
      gameBoard.add(List.filled(axisLen, ' '));
    }
  }

  void clear() {
    for (int i = 0; i < axisLen; i++) {
      gameBoard[i] = List.filled(axisLen, ' ');
    }
  }

  List<String> get spreadGameBoard {
    var spreadGameBoard = <String>[];
    for (final sublist in gameBoard) {
      spreadGameBoard.addAll(sublist);
    }
    return spreadGameBoard;
  }

  bool isMoveAvaliable() {
    for (var pos in spreadGameBoard) {
      if (pos == ' ') {
        return true;
      }
    }
    return false;
  }

  String checkColsForWinner() {
    for (int i = 0; i < axisLen; i++) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (gameBoard[i][j] == gameBoard[i][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return gameBoard[i][j];
        }
      }
    }
    return ' ';
  }

  String checkRowsForWinner() {
    for (int i = 0; i <= axisLen - winLimitNumber; i++) {
      for (int j = 0; j < axisLen; j++) {
        if (gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (gameBoard[i][j] == gameBoard[i + k][j]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return gameBoard[i][j];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopLeftForWinner() {
    for (int i = 0; i <= axisLen - winLimitNumber; i++) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (gameBoard[i][j] == gameBoard[i + k][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return gameBoard[i][j];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopRightForWinner() {
    for (int i = axisLen - 1; i >= winLimitNumber-1; i--) {
      for (int j = 0; j <= axisLen - winLimitNumber; j++) {
        if (gameBoard[i][j] == ' ') {
          continue;
        }
        int occurCount = 0;
        for (int k = 0; k < winLimitNumber; k++) {
          if (gameBoard[i][j] == gameBoard[i - k][j + k]) {
            occurCount++;
          }
        }
        if (occurCount == winLimitNumber) {
          return gameBoard[i][j];
        }
      }
    }

    return ' ';
  }
}
