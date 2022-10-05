import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final _formKey = GlobalKey<FormState>();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SizedBox(
        height: WidgetSizeConfig.screenHeight,
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 60.0,
          ),
       //   child: FormLoginWidget(emailTextController:_loginController.emailTextController,passwordTextController:_loginController.passwordTextController),
        ),
      ),
    );
  }
}
