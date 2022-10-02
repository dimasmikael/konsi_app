import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/ui/android/components/form/custom_button.dart';
import 'package:konsi_app/app/ui/android/components/form/custom_input.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isObscure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SizedBox(
        height: WidgetSizeConfig.screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              textFormSignIn(
                'Cadastre-se',
              ),
              CustomInputForm(
                icon: Icons.email_outlined,
                hint: "Email",
                label: "Email",
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
                  label: "Senha",
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure),
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
                  hint: "Confirmar Senha",
                  label: "Confirmar Senha",
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure),
              CustomdButtonFormWidget(
                buttonText: 'Cadastrar',
                width: WidgetSizeConfig.screenWidth! * 10,
                onpressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
