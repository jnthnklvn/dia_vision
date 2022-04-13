import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? onPressed;

  Future _speak() => Modular.get<LocalFlutterTts>().speak(text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(246, 36, 36, 36)
              : const Color(0xFFF5F6F9),
          primary: kPrimaryColor,
          minimumSize: const Size(100, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(20),
        ),
        onLongPress: _speak,
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Theme.of(context).textTheme.bodyText1?.color,
              width: 25,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ],
        ),
      ),
    );
  }
}
