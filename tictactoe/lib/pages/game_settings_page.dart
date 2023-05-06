import 'package:flutter/material.dart';
import 'package:tictactoe/custom_widgets/custom_textfield.dart';
import 'package:tictactoe/models/game_model.dart';
import 'package:tictactoe/pages/game_board_page.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage({super.key});

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late final int gameAxisLen;
  late final int gameWinLimit;
  int? tempGameAxisLen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(2, 3),
                      blurRadius: 20,
                      color: Colors.black,
                      blurStyle: BlurStyle.normal),
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFfcbf49),
                    Color(0xFFf77f00),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTextField(
                      text: 'Podaj wymiar planszy: ',
                      hintText: 'Wymiar',
                      width: 200,
                      onValidateCallback: (axisLen) {
                        if (int.tryParse(axisLen!) == null) {
                          return 'wprowadź numer';
                        }
                        if (int.parse(axisLen) > 10 || int.parse(axisLen) < 3) {
                          return 'wprowadź wartość\nmiędzy 3 i 10';
                        }
                        return null;
                      },
                      onSavedCallback: (axisLen) {
                        gameAxisLen = int.parse(axisLen!);
                      },
                      onChangedCallback: (axisLen) {
                        tempGameAxisLen = int.tryParse(axisLen!) ?? 10;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      text: 'Podaj ilośc kratek potrzebnych do wygranej: ',
                      hintText: 'Wymiar',
                      width: 200,
                      onValidateCallback: (winLimit) {
                        if (int.tryParse(winLimit!) == null) {
                          return 'wprowadź numer';
                        }
                        if (int.parse(winLimit) > tempGameAxisLen! ||
                            int.parse(winLimit) < 3) {
                          return 'wprowadź wartość\nmiędzy 3 i $tempGameAxisLen';
                        }
                        return null;
                      },
                      onSavedCallback: (winLimit) {
                        gameWinLimit = int.parse(winLimit!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                      onPressed: _saveForm,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Rozpocznij grę',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Theme.of(context).canvasColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Game(axisLen: gameAxisLen, winLimitNumber: gameWinLimit);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return GameBoardPage(boardAxisLen: gameAxisLen);
          },
        ),
      );
    }
  }
}
