import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget(
      {Key? key,
      required this.text,
      required this.colorIcon,
      required this.colorCard,
      required this.icon,
      required this.onTap})
      : super(key: key);

  final String? text;
  final Color? colorIcon, colorCard;
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);

    double width = WidgetSizeConfig.screenWidth!;
    double height = WidgetSizeConfig.screenHeight!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10,
          bottom: 20,
        ),
        child: SizedBox(
          height: height * .30,
          width: width * .70,
          child: Card(
            elevation: 10,
            color: colorCard,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.white),
            ),
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 80,
                      color: colorIcon,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
