import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final String semanticsLabel;
  final void Function()? onPressed;
  final String route;

  const FloatingAddButton(this.semanticsLabel, this.route,
      {Key? key, this.onPressed})
      : super(key: key);

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      sortKey: const OrdinalSortKey(0),
      child: InkWell(
        onLongPress: () => _speak(semanticsLabel),
        onTap: () => Modular.to.pushNamed("$route/"),
        child: Semantics(
          excludeSemantics: true,
          child: FloatingActionButton(
            onPressed: onPressed ?? () => Modular.to.pushNamed("$route/"),
            backgroundColor: kPrimaryColor,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      ),
      label: semanticsLabel,
    );
  }
}
