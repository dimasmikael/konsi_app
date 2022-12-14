import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/data/providers/auth_provider.dart';
import 'package:konsi_app/app/mixins/validations_mixin.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/android/components/buttons/custom_outlined_buttonn.dart';
import 'package:konsi_app/app/ui/android/components/form/custom_button.dart';
import 'package:konsi_app/app/ui/android/components/form/custom_input.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/auth/widgets_auth_page/form_auth/form_widget/google_button.dart';

class FormAuthnWidget extends StatefulWidget {
  FormAuthnWidget({
    Key? key,
    required this.emailTextController,
    required this.passwordTextController,
    required this.authProvider,
    required this.formKey,
  }) : super(key: key);
  final AuthProvider authProvider;
  TextEditingController? emailTextController = TextEditingController();
  TextEditingController? passwordTextController = TextEditingController();
  final GlobalKey<FormState> formKey;

  @override
  State<FormAuthnWidget> createState() => _FormAuthnWidgetState();
}

class _FormAuthnWidgetState extends State<FormAuthnWidget>
    with ValidationMixin {
  bool _isObscure = true;
  UserModel? user = UserModel();

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
              text: 'N??o tem conta? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Cadastre-se aqui',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
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

    setState(
      () {
        user?.email = widget.emailTextController!.text;
        user?.password = widget.passwordTextController!.text;
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            validator: (val) => combine([
                  () => isNotEmpty(val, 'Informe um email'),
                  () => checkEmail(val),
                ])),
        textLabelInput(
          'Senha',
        ),
        CustomInputForm(
            validator: (val) => combine(
                  [
                    () => isNotEmpty(val, 'Informe uma senha'),
                  ],
                ),
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
        CustomdButtonFormWidget(
            buttonText: 'Entrar',
            width: WidgetSizeConfig.screenWidth! * 10,
            onpressed: () async {
              if (widget.formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();

                await widget.authProvider
                    .signInWithEmailAndPassword(user, context);
              }
            }),
        _buildSignInWithText(),
        const SizedBox(
          height: 5,
        ),
        GoogleSignInButton(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildSignupBtn(),
            const SizedBox(height: 10.0),
            CustomOutlinedButton(
              color: Colors.teal,
              height: 50,
              width: 150,
              text: 'Cadastrar',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.register);
              },
            )
          ],
        ),
      ],
    );
  }
}
