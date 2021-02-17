import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../utils/constants.dart';
import 'text_field_container.dart';

import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: enabled,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: icon != null
              ? Icon(
                  icon,
                  color: kPrimaryColor,
                  size: 28,
                )
              : InkWell(
                  onTap: () => Modular.get<FlutterTts>().speak(hintText),
                  child: Icon(
                    Icons.play_circle_fill,
                    color: kPrimaryColor,
                    size: 28,
                  ),
                ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
