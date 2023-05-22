class GameBoard {
  final List<List<String>> gameBoard = [];
  final int axisLen;

  GameBoard({required this.axisLen});

  GameBoard.empty({required this.axisLen}) {
    for (int i = 0; i < axisLen; i++) {
      gameBoard.add(List.filled(axisLen, ' '));
    }
  }

  void clear() {
    for (int i = 0; i < axisLen; i++) {
      gameBoard.add(List.filled(axisLen, ' '));
    }
  }

  List<String> get spreadGameBoard {
    var spreadGameBoard = <String>[];
    for (final sublist in gameBoard) {
      spreadGameBoard.addAll(sublist);
    }
    return spreadGameBoard;
  }

  int evaluateBoard() {
    return 0;
  }

  bool isMoveAvaliable() {
    for (var pos in spreadGameBoard) {
      if (pos == ' ') {
        return true;
      }
    }
    return false;
  }

  void clearGameBoard() {
    for (int i = 0; i < axisLen; i++) {
      gameBoard[i] = List.filled(axisLen, ' ');
    }
  }

  void put(String player, int position) {
    gameBoard[position ~/ axisLen][position % axisLen] = player;
  }
}
