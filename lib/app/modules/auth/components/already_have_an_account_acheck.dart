import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function()? onPressed;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.onPressed,
  }) : super(key: key);

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: () => _speak(
        login ? doesntHaveAccountQst + signUp : hasAccountQst + signIn,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? doesntHaveAccountQst : hasAccountQst,
            style: const TextStyle(color: kPrimaryColor, fontSize: 18),
          ),
          Text(
            login ? signUp : signIn,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
