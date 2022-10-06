import 'package:flutter/material.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/android/components/card/custom_card.dart';


class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Container(
      margin: const EdgeInsets.only(top: 40),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomCard (
              icon: Icons.map,
              colorCard: Colors.green,
              colorIcon: Colors.white,
              text: "Meus Endereços",
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.home);

              },
            ),
            CustomCard (
              icon: Icons.add_location,
              colorCard: Colors.black,
              colorIcon: Colors.white,
              text: "Buscar Endereços",
              onTap: () {
                Navigator.of(context).pushNamed(Routes.addressSearch);

              },
            ),
          ],
        ),
      ),
    );
  }
}
