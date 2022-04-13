import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final void Function()? changeVisibility;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.hintText = passwordStr,
    this.obscureText = true,
    this.errorText,
    this.changeVisibility,
    this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasNextNode = nextFocusNode != null;
    return TextFieldContainer(
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        focusNode: focusNode,
        onSubmitted: hasNextNode
            ? (_) {
                focusNode?.unfocus();
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            : null,
        textInputAction:
            hasNextNode ? TextInputAction.next : TextInputAction.none,
        cursorColor: kPrimaryColor,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),
          errorText: errorText,
          hintText: hintText,
          icon: Semantics(
            excludeSemantics: true,
            child: InkWell(
              onTap: () => Modular.get<LocalFlutterTts>().speak(hintText),
              child: const Icon(
                Icons.play_circle_fill,
                color: kPrimaryColor,
                size: 42,
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap: changeVisibility,
            onLongPress: () => Modular.get<LocalFlutterTts>().speak(
                "$buttonStr ${(obscureText ? '' : 'não ')} 'exibir senha'"),
            child: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              semanticLabel:
                  "$buttonStr ${(obscureText ? '' : 'não ')} 'exibir senha'",
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
