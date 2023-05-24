import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/models/ai_model.dart';
import 'package:tictactoe/models/game_model.dart';

class GameBoardPage extends StatefulWidget {
  const GameBoardPage({super.key, required this.boardAxisLen});
  final int boardAxisLen;

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  bool isXTurn = true;
  AiModel model = AiModel();

  @override
  Widget build(BuildContext context) {
    String turnText = isXTurn ? 'X' : 'O';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 110,
              child: Text(
                'Turn: $turnText',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0xFFf77f00),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(2, 3),
                        blurRadius: 30,
                        color: Colors.black,
                        blurStyle: BlurStyle.normal),
                  ]),
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Game().spreadGameBoard.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  maxCrossAxisExtent:
                      MediaQuery.of(context).size.height / widget.boardAxisLen,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      onTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        border: Border.all(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Game().spreadGameBoard[index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
              ),
              onPressed: () {
                setState(() {
                  Game().clearGameBoard();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Restart',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Theme.of(context).canvasColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    if (Game().spreadGameBoard[index] == ' ') {
      setState(() {
        if (isXTurn) {
          Game().spreadGameBoard[index] = 'X';
          Game().putFromIndex('X', index);
        } else {
          Game().spreadGameBoard[index] = 'O';
          Game().putFromIndex('O', index);
        }
        // isXTurn = !isXTurn;
      });
      String winnner = Game().findWinner();
      if (winnner == ' ') {
        compute(
          model.findBestMove,
          Game().gameBoard,
        ).then((move) {
          setState(() {
            Game().putFromPoint('O', move);
          });
        });

        //   Point move = model.findBestMove(Game().gameBoard);
        //   setState(() {
        //     Game().putFromPoint('O', move);
        //   });
      }
      if (winnner != ' ') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('winner is $winnner'),
            );
          },
        );
      } else if (Game().spreadGameBoard.every((element) => element != ' ')) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('draw'),
            );
          },
        );
      }
    }
  }
}
