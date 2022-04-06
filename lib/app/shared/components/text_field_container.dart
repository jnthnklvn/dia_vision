import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(246, 36, 36, 36)
            : const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
