import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function()? onPressed;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.onPressed,
  }) : super(key: key);

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: () => _speak(
        login ? doesntHaveAccountQst + signUp : hasAccountQst + signIn,
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: login ? doesntHaveAccountQst : hasAccountQst,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: kPrimaryColor),
            ),
            TextSpan(
              text: login ? signUp : signIn,
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
