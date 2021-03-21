import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function() onPressed;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.onPressed,
  }) : super(key: key);

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: () => _speak(
        login
            ? ASK_DOESNT_HAVE_ACCOUNT + REGISTER_YOUR
            : ASK_HAVE_ACCOUNT + GO_IN,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? ASK_DOESNT_HAVE_ACCOUNT : ASK_HAVE_ACCOUNT,
            style: TextStyle(color: kPrimaryColor, fontSize: 18),
          ),
          Text(
            login ? REGISTER_YOUR : GO_IN,
            style: TextStyle(
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
