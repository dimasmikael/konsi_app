import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/config/config_page.dart';
import 'package:konsi_app/app/ui/android/pages/home/widgets_home_page/card_home_widget.dart';

import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();


  int selectedpage = 0;
  final _pageNo = [
    Container(
      margin: const EdgeInsets.only(top: 40),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardHomeWidget(
              icon: Icons.map,
              colorCard: Colors.green,
              colorIcon: Colors.white,
              text: "Meus Endereços",
              onTap: () {},
            ),
            CardHomeWidget(
              icon: Icons.add_location,
              colorCard: Colors.black,
              colorIcon: Colors.white,
              text: "Buscar Endereços",
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
    const ConfigPage()
  ];
  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    double width = WidgetSizeConfig.screenWidth!;
    double height = WidgetSizeConfig.screenHeight!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          textAlign: TextAlign.center,
        ),
      ),
      body: _pageNo[selectedpage],
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        backgroundColor: const Color(0xff2DB999),
        activeColor: Colors.black,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.settings, title: 'Configurações'),
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
    );
  }
}

//       body:
//
//       Container(
//         decoration: BoxDecoration(color: Colors.white),
//         child: Center(
//           child: _getPage(currentPage),
//         ),
//       ),
//
//
//     );
//   }
// }
