import 'package:dia_vision/app/modules/autocuidado/controllers/autocuidado_controller.dart';
import 'package:dia_vision/app/modules/autocuidado/widgets/autocuidado_widget.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class AutocuidadosPage extends StatefulWidget with ScaffoldUtils {
  @override
  _AutocuidadosPageState createState() => _AutocuidadosPageState(scaffoldKey);
}

class _AutocuidadosPageState
    extends ModularState<AutocuidadosPage, AutocuidadoController>
    with DateUtils {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AutocuidadosPageState(this.scaffoldKey);
  
  @override
  void didChangeDependencies() {
    controller.getData(widget.onError);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Padding(padding: const EdgeInsets.all(8.0)),
        ],
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            SELF_CARE_TITLE,
            style: TextStyle(
              fontSize: 24,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10),
        child: Observer(
          builder: (_) {
            if (controller.isLoading)
              return Center(child: CircularProgressIndicator());
            if (controller.autocuidados.isEmpty)
              return InkWellSpeakText(
                Text(
                  WITHOUT_SELF_CARE_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              );
            return ListView.builder(
              itemCount: controller.autocuidados.length,
              itemBuilder: (BuildContext context, int index) {
                return AutocuidadoWidget(controller.autocuidados[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
