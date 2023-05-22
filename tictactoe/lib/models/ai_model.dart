import 'package:tictactoe/models/board_model.dart';

class AiModel {
  static const _maxDepth = 6;

  int minMax(GameBoard board, int position, int depth, int alpha, int beta,
      String maximizingPlayer) {
    if (depth == 0 || !board.isMoveAvaliable()) {
      return 0;
    }

    if (maximizingPlayer == 'X') {
      double maxEval = double.negativeInfinity;
    } else {
      double maxEval = double.infinity;
    }
    return 0;
  }
}
