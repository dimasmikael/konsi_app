import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/data/providers/auth_provider.dart';
import 'package:konsi_app/app/routes/routes.dart';
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

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isObscure = true;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    final authProvider = Provider.of<AuthProvider>(context);

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
        child:
        Form(
        key: _formKey,child:
        SingleChildScrollView(
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
              ),
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
                  obscureText: _isObscure),
              textLabelInput(
                'Confirmar',
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
                  hint: "Confirmar Senha",
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure),

              authProvider.status == Status.Registering
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  :
              CustomdButtonFormWidget(
                buttonText: 'Cadastrar',
                width: WidgetSizeConfig.screenWidth! * 10,
                onpressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  //   FocusScope.of(context)
                  //       .unfocus(); //to hide the keyboard - if any

                    UserModel userModel =
                    await authProvider.registerWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text);

                    if (userModel == null) {
                      // _scaffoldKey.currentState!.showSnackBar(SnackBar(
                      //   content:
                        Text(
                            "loginTxtErrorSignIn");
                      // ));
                    }
                //  }
                }
              ),

    authProvider.status == Status.Registering
    ? Center(
    child: null,
    )
        : Padding(
    padding: const EdgeInsets.only(top: 48),
    child: Center(
    child: Text(

      ("loginTxtHaveAccount"),
    style: Theme.of(context).textTheme.button,
    )),
    ),

    authProvider.status == Status.Registering
    ? const Center(
    child: null,
    )
        : TextButton(
    child: const Text(("loginBtnLinkSignIn"),),
    //  textColor: Theme.of(context).iconTheme.color,
    onPressed: () {
    Navigator.of(context)
        .pushReplacementNamed(Routes.login);
    },
    ),
            ],
          ),
        ),
      ),
      ),   );
  }
}
