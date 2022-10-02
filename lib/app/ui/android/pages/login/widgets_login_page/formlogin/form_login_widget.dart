import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:konsi_app/app/ui/android/components/form/custom_button.dart';
import 'package:konsi_app/app/ui/android/components/form/custom_input.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';

class FormLoginWidget extends StatefulWidget {
  FormLoginWidget({Key? key}) : super(key: key);

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  bool _isObscure = true;

  Widget _buttonGoogle() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      onPressed: () {
        // googleLogin();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/images/google-logo.png"),
              height: 18.0,
              width: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 8),
              child: Text(
                'Entre com o  Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    return Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(),

        const SizedBox(),
        Column(
          children: [
            textFormSignIn(
              'Entrar',
            ),
            CustomInputForm(
              icon: Icons.email_outlined,
              hint: "Email",
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            CustomInputForm(
                icon: Icons.lock_outline,
                suffixIcon: IconButton(
                  color: Colors.black.withOpacity(.7),
                  onPressed: () {
                    setState(
                      () {
                        _isObscure = !_isObscure;
                      },
                    );
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                hint: "Senha",
                keyboardType: TextInputType.text,
                obscureText: _isObscure),
            CustomdButtonFormWidget(
              buttonText: 'Entrar',
              width: WidgetSizeConfig.screenWidth! * 10,
              onpressed: () {},
            ),
          ],
        ),
        Column(
          children: [
            textGoogle(
              'Ou, entre com sua conta do google',
            ),
            _buttonGoogle()
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Não tem conta?',
            ),
            TextButton(onPressed: () {}, child: const Text('Cadastre-se'))
          ],
        ),
      ],
    );
  }
}
