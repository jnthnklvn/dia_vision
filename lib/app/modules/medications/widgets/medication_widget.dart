import 'package:dia_vision/app/shared/utils/color_utils.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class MedicationWidget extends StatelessWidget {
  final String medicationName;
  final String medicationPosology;

  const MedicationWidget(this.medicationName, this.medicationPosology);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () =>
          Modular.get<FlutterTts>().speak(medicationName + medicationPosology),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils
              .colors[medicationName.hashCode % ColorUtils.colors.length],
        ),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFF01215e),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  medicationName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  medicationPosology,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
