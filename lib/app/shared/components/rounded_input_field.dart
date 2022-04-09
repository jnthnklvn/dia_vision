import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const RoundedInputField({
    Key? key,
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
    this.suffixIcon,
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
                focusNode?.unfocus();
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            : null,
        textInputAction:
            hasNextNode ? TextInputAction.next : TextInputAction.done,
        cursorColor: kPrimaryColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: hintText,
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),
          suffixIcon: suffixIcon,
          icon: Semantics(
            excludeSemantics: true,
            child: icon != null
                ? Icon(
                    icon,
                    color: kPrimaryColor,
                    size: 42,
                  )
                : InkWell(
                    onTap: () => Modular.get<FlutterTts>()
                        .speak("$hintText: ${controller?.text ?? ""}"),
                    child: const Icon(
                      Icons.play_circle_fill,
                      color: kPrimaryColor,
                      size: 42,
                    ),
                  ),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
