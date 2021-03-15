import 'package:dia_vision/app/shared/utils/constants.dart';
import 'text_field_container.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String errorText;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.focusNode,
    this.nextFocusNode,
    this.inputFormatters,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasNextNode = nextFocusNode != null;
    return TextFieldContainer(
      child: TextField(
        inputFormatters: inputFormatters,
        enabled: enabled,
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        onSubmitted: hasNextNode
            ? (_) {
                focusNode.unfocus();
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            : null,
        textInputAction:
            hasNextNode ? TextInputAction.next : TextInputAction.none,
        cursorColor: kPrimaryColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: hintText,
          icon: icon != null
              ? Icon(
                  icon,
                  color: kPrimaryColor,
                  size: 42,
                )
              : InkWell(
                  onTap: () => Modular.get<FlutterTts>().speak(hintText),
                  child: Icon(
                    Icons.play_circle_fill,
                    color: kPrimaryColor,
                    size: 42,
                  ),
                ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
