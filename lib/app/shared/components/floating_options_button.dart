import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class FloatingOptionsButton extends StatelessWidget {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final controller = Modular.get<AppController>();

  FloatingOptionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DraggableFab(
      child: ValueListenableBuilder<bool>(
        valueListenable: controller.themeSwitch,
        builder: (_, isDarkMode, __) {
          return MaterialButton(
            onLongPress: () =>
                _speak(isDarkMode ? turnOffDarkMode : turnOnDarkMode),
            onPressed: () => controller.toggleTheme(!isDarkMode),
            child: SizedBox(
              height: 80,
              width: 80,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: isDark ? Colors.white : Colors.black,
                  onPressed: () => controller.toggleTheme(!isDarkMode),
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    semanticLabel:
                        isDarkMode ? turnOffDarkMode : turnOnDarkMode,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
