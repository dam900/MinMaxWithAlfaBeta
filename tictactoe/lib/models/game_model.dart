// ignore_for_file: public_member_api_docs, sort_constructors_first

class Game {
  final int axisLen;
  final int winLimitNumber;
  List<String> _gameBoard = [];

  static Game? _game;
  factory Game({int axisLen = 3, int winLimitNumber = 3}) {
    return _game ??=
        Game._internal(axisLen: axisLen, winLimitNumber: winLimitNumber);
  }

  Game._internal({required this.axisLen, required this.winLimitNumber}) {
    _gameBoard = List.filled(axisLen * axisLen, ' ');
  }

  List<String> get gameBoard => _gameBoard;

  void clearGameBoard() {
    _gameBoard = List.filled(axisLen * axisLen, ' ');
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
    int colTrack = 1;

    for (int tileNumber = 0; tileNumber < axisLen * axisLen; tileNumber++) {
      colTrack = tileNumber ~/ axisLen + 1;

      if (gameBoard[tileNumber] == ' ') {
        continue;
      }
      if (tileNumber >= 1 + colTrack * axisLen - winLimitNumber) {
        continue;
      }

      int occurCount = 0;
      int maxColIndex = colTrack * axisLen;

      for (int j = tileNumber; j < tileNumber + winLimitNumber; j++) {
        if (j == maxColIndex) {
          break;
        }

        if (gameBoard[tileNumber] == gameBoard[j]) {
          occurCount++;
        }
      }

      if (occurCount == winLimitNumber) {
        return gameBoard[tileNumber];
      }
    }
    return ' ';
  }

  String checkRows() {
    int maxLen = axisLen * axisLen;
    int rowTrack = 1;
    int maxRelevantTileNumber = axisLen * (axisLen + 1 - winLimitNumber);

    for (int tileNumber = 0; tileNumber < maxLen; tileNumber++) {
      if (tileNumber >= maxRelevantTileNumber) {
        break;
      }

      rowTrack = tileNumber % axisLen + 1;
      if (gameBoard[tileNumber] == ' ') {
        continue;
      }

      int occurCount = 0;

      for (int j = tileNumber;
          j < axisLen * (winLimitNumber - 1) + rowTrack + tileNumber;
          j += axisLen) {
        if (j >= maxLen) {
          break;
        }
        if (gameBoard[tileNumber] == gameBoard[j]) {
          occurCount++;
        }
      }

      if (occurCount == winLimitNumber) {
        return gameBoard[tileNumber];
      }
    }
    return ' ';
  }

  String checkDiagonalsTopLeftBottomRight() {
    int maxLen = axisLen * axisLen;
    int bounds = 1 + axisLen - winLimitNumber;

    for (int tileNumber = 0; tileNumber < maxLen; tileNumber++) {
      if (gameBoard[tileNumber] == ' ' || tileNumber % axisLen >= bounds) {
        continue;
      }
      if (tileNumber >= bounds * axisLen) {
        continue;
      }

      int occurCount = 0;
      for (int j = tileNumber;
          j < tileNumber + winLimitNumber * axisLen + winLimitNumber - 1;
          j += axisLen + 1) {
        if (gameBoard[tileNumber] == gameBoard[j]) {
          occurCount++;
        }
        if (occurCount == winLimitNumber) {
          return gameBoard[tileNumber];
        }
      }
    }

    return ' ';
  }

  String checkDiagonalsTopRightBottomLeft() {
    int maxLen = axisLen * axisLen;
    int bounds = winLimitNumber - 1;

    for (int tileNumber = 0; tileNumber < maxLen; tileNumber++) {
      if (gameBoard[tileNumber] == ' ' || tileNumber ~/ axisLen < bounds) {
        continue;
      }
      if (tileNumber % axisLen >= (axisLen - bounds)) {
        continue;
      }
      int occurCount = 0;
      for (int j = tileNumber;
          j >= tileNumber - bounds * axisLen + winLimitNumber - 1;
          j -= axisLen - 1) {
        if (gameBoard[tileNumber] == gameBoard[j]) {
          occurCount++;
        }
        if (occurCount == winLimitNumber) {
          return gameBoard[tileNumber];
        }
      }
    }

    return ' ';
  }
}
