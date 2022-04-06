import 'package:dia_vision/app/modules/app_visao/controllers/app_visao_controller.dart';
import 'package:dia_vision/app/modules/app_visao/widgets/app_visao_widget.dart';
import 'package:dia_vision/app/shared/components/floating_add_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

class AppsVisaoPage extends StatefulWidget with ScaffoldUtils {
  AppsVisaoPage({Key? key}) : super(key: key);

  @override
  _AppsVisaoPageState createState() => _AppsVisaoPageState();
}

class _AppsVisaoPageState
    extends ModularState<AppsVisaoPage, AppVisaoController> {
  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      floatingActionButton: FloatingAddButton(
        "$buttonStr $suggestStr $visionAppTitle",
        "${vision.routeName}/$registerStr",
      ),
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            visionApps,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Semantics(
        sortKey: const OrdinalSortKey(1),
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Observer(
            builder: (_) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.apps.isEmpty) {
                return const InkWellSpeakText(
                  Text(
                    withoutVisionAppRegistered,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.apps.length,
                itemBuilder: (BuildContext context, int index) {
                  return AppVisaoWidget(controller.apps[index], widget.onError);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
