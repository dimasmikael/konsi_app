import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/data/providers/auth_provider.dart';
import 'package:konsi_app/app/mixins/validations_mixin.dart';
import 'package:konsi_app/app/routes/routes.dart';

import 'package:konsi_app/app/ui/android/components/form/custom_button.dart';
import 'package:konsi_app/app/ui/android/components/form/custom_input.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';

class FormAuthnWidget extends StatefulWidget {
  FormAuthnWidget({
    Key? key,
    required this.emailTextController,
    required this.passwordTextController,
    required this.authProvider,
    required this.formKey,
    required this.scaffoldKey,
  }) : super(key: key);
  final AuthProvider authProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  TextEditingController? emailTextController = TextEditingController();
  TextEditingController? passwordTextController = TextEditingController();

  @override
  State<FormAuthnWidget> createState() => _FormAuthnWidgetState();
}

class _FormAuthnWidgetState extends State<FormAuthnWidget>
    with ValidationMixin {
  bool _isObscure = true;

  Widget _buttonGoogle() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          '- OU -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Entrar com',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Não tem conta? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            TextSpan(
              text: 'Clique aqui',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // onPressed: () {
            //   Navigator.of(context)
            //       .pushReplacementNamed(Routes.register);
            // },
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textFormSignIn(
          'Entrar',
        ),
        const SizedBox(height: 10.0),
        textLabelInput(
          'Email',
        ),
        CustomInputForm(
            controller: widget.emailTextController,
            icon: Icons.email_outlined,
            hint: "Email",
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            validator: (val) =>
                combine([
                  () => isNotEmpty(val, 'Informe um email'),

                      () => checkEmail(val),



                ])),
        textLabelInput(
          'Senha',
        ),
        CustomInputForm(
            validator: (val) =>
                combine([() => isNotEmpty(val, 'Informe uma senha')]),
            controller: widget.passwordTextController,
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
        widget.authProvider.status == Status.Authenticating
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomdButtonFormWidget(
                buttonText: 'Entrar',
                width: WidgetSizeConfig.screenWidth! * 10,
                onpressed: () async {
                  if (widget.formKey.currentState!.validate()) {
                    FocusScope.of(context)
                        .unfocus(); //to hide the keyboard - if any

                    bool status = await widget.authProvider
                        .signInWithEmailAndPassword(
                            widget.emailTextController!.text,
                            widget.passwordTextController!.text);

                    if (!status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("textAlert(text)"),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(
                            label: "",
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      );

                      // widget.scaffoldKey.currentState!._scaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text(AppLocalizations.of(context)
                      //       .translate("loginTxtErrorSignIn")),
                      // )
                      //   )//;
                    } else {
                      if (mounted) {
                        Navigator.of(context).pushReplacementNamed(Routes.home);
                      }
                    }
                  }
                }),
        _buildSignInWithText(),
        const SizedBox(
          height: 5,
        ),
        _buttonGoogle(),
        const SizedBox(
          height: 10,
        ),
        widget.authProvider.status == Status.Authenticating
            ? Center(
                child: null,
              )
            : _buildSignupBtn(),
        widget.authProvider.status == Status.Authenticating
            ? Center(
                child: null,
              )
            : TextButton(
                child: Text("loginBtnLinkCreateAccount"),
                //    textColor: Theme.of(context).iconTheme.color,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.register);
                },
              ),
      ],
    );
  }
}
