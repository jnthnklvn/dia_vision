import 'package:dia_vision/app/modules/auth/components/already_have_an_account_acheck.dart';
import 'package:dia_vision/app/modules/auth/register/register_controller.dart';
import 'package:dia_vision/app/shared/components/rounded_password_field.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget with ScaffoldUtils {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(scaffoldKey);
}

class _RegisterPageState extends ModularState<RegisterPage, RegisterController>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  _RegisterPageState(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: SingleChildScrollView(
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const [BackArrowButton()],
                ),
                SizedBox(height: size.height * 0.08),
                Image.asset(
                  "assets/images/logo_name.png",
                  width: size.width * 0.8,
                  excludeFromSemantics: true,
                ),
                SizedBox(height: size.height * 0.1),
                RoundedInputField(
                  hintText: "Email",
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: controller.setEmail,
                  errorText: controller.emailError,
                ),
                RoundedPasswordField(
                  focusNode: _focusNode2,
                  errorText: controller.passwordError,
                  onChanged: controller.setPassword,
                  obscureText: controller.isPasswordHide,
                  changeVisibility: controller.setIsPasswordHide,
                ),
                controller.isLoading
                    ? Center(
                        child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const CircularProgressIndicator(),
                      ))
                    : RoundedButton(
                        text: "REGISTRAR",
                        onPressed: () => controller.register(
                          widget.onError,
                          () async {
                            widget.onSuccess(registeredWithSuccess);
                            controller.setPassword(null);
                            controller.setEmail(null);
                            await Future.delayed(const Duration(seconds: 1));
                            Modular.to
                                .pushReplacementNamed(RouteEnum.home.name);
                          },
                        ),
                      ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  onPressed: Modular.to.pop,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
