import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/theme_params.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:quds_ui_kit/screens/quds_popup_menu.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {
      return null;
    }
  }
}

class FloatingOptionsButton extends StatefulWidget {
  final bool? visible;
  const FloatingOptionsButton({Key? key, this.visible}) : super(key: key);

  @override
  State<FloatingOptionsButton> createState() => _FloatingOptionsButtonState();
}

class _FloatingOptionsButtonState extends State<FloatingOptionsButton> {
  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);
  final containerKey = GlobalKey();

  final controller = Modular.get<AppController>();

  void onPressed(bool isDark) {
    final startOffset = Offset(
      containerKey.globalPaintBounds?.left ?? 0,
      containerKey.globalPaintBounds?.top ?? 0,
    );
    final endOffset = Offset(
      containerKey.globalPaintBounds?.right ?? 0,
      containerKey.globalPaintBounds?.bottom ?? 0,
    );
    showQudsPopupMenu(
      startOffset: startOffset,
      endOffset: endOffset,
      context: context,
      items: getMenuItems(isDark),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ValueListenableBuilder<bool>(
        valueListenable: controller.accBttnVisibilitySwitch,
        builder: (_, isAccBttnVisible, __) {
          if (!isAccBttnVisible && widget.visible != true) return Container();
          return DraggableFab(
            child: FloatingActionButton(
              key: containerKey,
              backgroundColor: isDark ? Colors.white : Colors.black,
              onPressed: () => onPressed(isDark),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: InkWell(
                  onTap: () => onPressed(isDark),
                  onLongPress: () => _speak(accButtonDesc),
                  child: Icon(
                    Icons.settings_accessibility,
                    size: 32,
                    semanticLabel: accButtonDesc,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<QudsPopupMenuBase> getMenuItems(bool isDarkMode) {
    return [
      QudsPopupMenuItem(
        title: const Text(fontSize),
        leading: ValueListenableBuilder<ThemeParams>(
          valueListenable: controller.themeSwitch,
          builder: (_, themeParams, __) {
            return InkWell(
              onTap: () => controller.toggleTheme(
                ThemeParams(
                  themeParams.isDarkMode,
                  themeParams.fontScale - 0.1,
                ),
              ),
              onLongPress: () => _speak(decFontSize),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(
                  Icons.remove,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
            );
          },
        ),
        trailing: ValueListenableBuilder<ThemeParams>(
          valueListenable: controller.themeSwitch,
          builder: (_, themeParams, __) {
            return InkWell(
              onTap: () => controller.toggleTheme(
                ThemeParams(
                  themeParams.isDarkMode,
                  themeParams.fontScale + 0.1,
                ),
              ),
              onLongPress: () => _speak(incFontSize),
              radius: 20,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(
                  Icons.add,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
            );
          },
        ),
        popOnTap: false,
        onPressed: () => _speak(customFontSizeDesc),
        onLongPressed: () => _speak(customFontSizeDesc),
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
        title: Text(controller.isAccBttnVisible
            ? hideAccessibilityButton
            : showAccessibilityButton),
        onPressed: () => controller.toggleAccBttnVisibility(),
        onLongPressed: () => _speak(controller.isAccBttnVisible
            ? hideAccessibilityButton
            : showAccessibilityButton),
      ),
      QudsPopupMenuItem(
        title: const Text(goToSettings),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onPressed: () => Modular.to.pushNamed('${RouteEnum.profile.name}/'),
        onLongPressed: () => _speak(goToSettingsDesc),
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
        title: const Text(goToBegin),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onPressed: () => Modular.to.popUntil((r) => r.isFirst),
        onLongPressed: () => _speak(goToBeginDesc),
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuWidget(
        builder: (c) => Container(
          padding: const EdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<ThemeParams>(
                  valueListenable: controller.themeSwitch,
                  builder: (_, themeParams, __) {
                    return InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () => controller.toggleTheme(
                        ThemeParams(
                          !themeParams.isDarkMode,
                          themeParams.fontScale,
                        ),
                      ),
                      onLongPress: () => _speak(themeParams.isDarkMode
                          ? turnOffDarkMode
                          : turnOnDarkMode),
                      child: Icon(
                        themeParams.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        size: 42,
                        semanticLabel: themeParams.isDarkMode
                            ? turnOffDarkMode
                            : turnOnDarkMode,
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
                const VerticalDivider(),
                ValueListenableBuilder<bool>(
                  valueListenable: controller.voiceFeedbackSwitch,
                  builder: (_, isVoiceFeedbackActive, __) {
                    return InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () => controller
                          .toggleVoiceFeedback(!isVoiceFeedbackActive),
                      onLongPress: () => _speak(isVoiceFeedbackActive
                          ? turnOffVoiceFeedback
                          : turnOnVoiceFeedback),
                      child: Icon(
                        isVoiceFeedbackActive
                            ? Icons.music_off
                            : Icons.music_note,
                        size: 42,
                        semanticLabel: isVoiceFeedbackActive
                            ? turnOffVoiceFeedback
                            : turnOnVoiceFeedback,
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
