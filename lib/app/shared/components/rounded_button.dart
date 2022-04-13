import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final Color? color, textColor;
  final double? width;

  const RoundedButton({
    Key? key,
    this.text,
    this.onPressed,
    this.color = kPrimaryColor,
    this.textColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width ?? (size.width * 0.9),
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(primary: kPrimaryColor),
          onLongPress: () => Modular.get<LocalFlutterTts>()
              .speak("$buttonStr " + (text ?? '')),
          child: Text(
            (text ?? ''),
            style: TextStyle(
                color: textColor ?? Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
