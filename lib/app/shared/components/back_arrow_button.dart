import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackArrowButton extends StatelessWidget {
  final double iconPadding;

  const BackArrowButton({
    Key? key,
    this.iconPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "$buttonStr $backStr",
      child: InkWell(
        onTap: Modular.to.pop,
        onLongPress: () =>
            Modular.get<LocalFlutterTts>().speak("$buttonStr $backStr"),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Padding(
            padding: EdgeInsets.all(iconPadding),
            child: SvgPicture.asset(
              "assets/icons/Back ICon.svg",
              color: kPrimaryColor,
              height: 30,
              excludeFromSemantics: true,
            ),
          ),
        ),
      ),
    );
  }
}
