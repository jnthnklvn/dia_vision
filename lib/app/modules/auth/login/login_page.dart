import 'package:dia_vision/app/modules/auth/components/already_have_an_account_acheck.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/rounded_password_field.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/components/confirm_dialog.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget with ScaffoldUtils {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController>
    with SingleTickerProviderStateMixin {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  Future<void> _showMyDialog(Function() onConfirm) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmDialog(
          onConfirm,
          allowNotifications,
          wishToAllowNotifications,
        );
      },
    );
  }

  Future<void> requestNotificationPermission() async {
    final awesomeNotifications = Modular.get<AwesomeNotifications>();
    await awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        _showMyDialog(
            awesomeNotifications.requestPermissionToSendNotifications);
      }
    });
  }

  Future<void> isUserLogged() async {
    final isLogged = await Modular.get<AppController>().isLogged();
    if (isLogged) Modular.to.pushReplacementNamed('${RouteEnum.home.name}/');
    await requestNotificationPermission();
  }

  @override
  void initState() {
    isUserLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? Colors.white10 : Theme.of(context).backgroundColor,
      key: widget.scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.15),
                Image.asset(
                  "assets/images/logo_name.png",
                  width: size.width * 0.8,
                  excludeFromSemantics: true,
                  color: isDark ? kPrimaryColor : null,
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
                        text: "ENTRAR",
                        onPressed: () => controller.login(
                          widget.onError,
                          () => Modular.to
                              .pushReplacementNamed('${RouteEnum.home.name}/'),
                        ),
                      ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  onPressed: () => Modular.to
                      .pushNamed(RouteEnum.auth.name + RouteEnum.register.name),
                ),
                GestureDetector(
                  onTap: () => Modular.to
                      .pushNamed(RouteEnum.auth.name + RouteEnum.recovery.name),
                  onLongPress: () =>
                      _speak(forgotPasswordQst + recoveryPassword),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: forgotPasswordQst,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: kPrimaryColor),
                        ),
                        const TextSpan(
                          text: recoveryPassword,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
