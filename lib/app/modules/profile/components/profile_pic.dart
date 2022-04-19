import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final Function(String txt) _speak;

  const ProfilePic(
    this._speak, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _speak(profileImgSemanticDesc),
      child: Semantics(
        label: profileImgSemanticDesc,
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                child: Icon(Icons.person, size: 100),
                backgroundColor: kSecondaryColor,
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(246, 36, 36, 36)
                              : const Color(0xFFF5F6F9),
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {},
                    onLongPress: () => _speak(profileImgSemanticDesc),
                    child: SvgPicture.asset(
                      "assets/icons/Camera Icon.svg",
                      color: kPrimaryColor,
                      semanticsLabel: profileImgSemanticDesc,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
