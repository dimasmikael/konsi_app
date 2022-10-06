import 'package:flutter/material.dart';
import 'package:konsi_app/app/data/providers/auth_provider.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:konsi_app/app/ui/android/components/appbar/custom_appbar.dart';
import 'package:konsi_app/app/ui/android/components/loading/loading_widget.dart';
import 'package:provider/provider.dart';
import "dart:math";

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  //final LoadingWidget loadingWidget = LoadingWidget();
  bool _isSigningIn = false;
  @override
  bool mounted = false;

  List names = ['Jerry', 'Mark', 'John', 'Maria', 'Paula', 'Livia'];

  _confirmSignOut(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              material: (_, PlatformTarget target) => MaterialAlertDialogData(
                  backgroundColor: Theme.of(context).appBarTheme.color),
              title: const Text("Atenção"),
              content: const Text("Tem certeza que quer sair?"),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText(("Cancelar")),
                  onPressed: () => Navigator.pop(context),
                ),
                PlatformDialogAction(
                  child: PlatformText(
                    "Confirmar",
                  ),
                  onPressed: () async {
                    setState(() {
                      _isSigningIn = true;
                    });

                    // await Future.delayed(const Duration(milliseconds: 5000),
                    //     () {
                    //   loadingWidget.openLoadingDialog(context, 'Saindo...');
                    // });



                    // if(authProvider.checkLoggedUser() == null){
                    //   await authProvider.signOutGoogle(context: context);
                    // }else{
                    //   if (!mounted) {}
                    await authProvider.signOut(context);
                    // }

                    if (!mounted) {}
                    await Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, (Route<dynamic> route) => false);

                    setState(() {
                      _isSigningIn = false;
                    });
                  },
                )
              ],
            ));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Card(
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage("https://i.pravatar.cc/300"),
                        ),
                      ),
                      Text(names[Random().nextInt(names.length - 1)])
                    ],
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Deslogar"),
                onTap: () async {
                  _confirmSignOut(context);
                },
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
