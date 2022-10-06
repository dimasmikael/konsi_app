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
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with ValidationMixin {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isObscure = true;
  UserModel? user = UserModel();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Já tem conta? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            TextSpan(
              text: 'Entre aqui',
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
    final authProvider = Provider.of<AuthProvider>(context);

    setState(() {
      user?.email = _emailController.text;
      user?.password = _passwordController.text;
    });

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SizedBox(
        height: WidgetSizeConfig.screenHeight,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 60.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFormSignIn(
                  'Cadastrar',
                ),
                const SizedBox(height: 10.0),
                textLabelInput(
                  'Email',
                ),
                CustomInputForm(
                    controller: _emailController,
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
                  controller: _passwordController,
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
                  obscureText: _isObscure,
                  validator: (val) => combine(
                    [
                      () => isNotEmpty(val, 'Informe uma senha'),
                      () => hasSevenChars(val)
                    ],
                  ),
                ),
                textLabelInput(
                  'Confirmar',
                ),
                // CustomInputForm(
                //   controller: _confirmPasswordController,
                //   icon: Icons.lock_outline,
                //   suffixIcon: IconButton(
                //     color: Colors.black.withOpacity(.7),
                //     onPressed: () {
                //       setState(
                //         () {
                //           _isObscure = !_isObscure;
                //         },
                //       );
                //     },
                //     icon: Icon(
                //       _isObscure ? Icons.visibility : Icons.visibility_off,
                //     ),
                //   ),
                //   hint: "Confirmar Senha",
                //   keyboardType: TextInputType.text,
                //   obscureText: _isObscure,
                //   validator: (val) => combine(
                //     [
                //       () => confirmPassword(
                //           val,
                //           val != _passwordController.text
                //               ? 'As senhas devem ser iguais'
                //               : '3232'),
                //
                //     ],
                //   ),
                // ),
                CustomdButtonFormWidget(
                    buttonText: 'Cadastrar',
                    width: WidgetSizeConfig.screenWidth! * 10,
                    onpressed: () async {
                      //   if (_formKey.currentState!.validate()) {
                      FocusScope.of(context)
                          .unfocus(); //to hide the keyboard - if any
                      await authProvider.registerWithEmailAndPassword(
                          user, context);
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(child: _buildSignupBtn()


                      ),
                ),

                CustomOutlinedButton(
                  height: 50,
                  width: 150,
                  text: 'Entrar',
                    onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.login);
          },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
