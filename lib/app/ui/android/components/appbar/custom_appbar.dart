import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';


class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(
        WidgetSizeConfig.blockSizeVertical! * 12,
      ),
      child: AppBar(
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(
            size: WidgetSizeConfig.safeBlockHorizontal! * 6, color: Colors.white),
        title: textAppBar(text!),
      ),
    );
  }
}
