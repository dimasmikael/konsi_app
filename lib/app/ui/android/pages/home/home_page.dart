import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/home/widgets_home_page/card_home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    double width = WidgetSizeConfig.screenWidth!;
    double height = WidgetSizeConfig.screenHeight!;
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          "Dashboard",
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: height,
        margin: const EdgeInsets.only(top: 40),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              CardHomeWidget(
                icon: Icons.map,
                colorCard: Colors.amber,
                colorIcon: Colors.white,
                text: "Texto",
                onTap: () {},
              ),
              CardHomeWidget(
                icon: Icons.add_location,
                colorCard: Colors.blueAccent,
                colorIcon: Colors.white,
                text: "Texto",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
