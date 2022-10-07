import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:konsi_app/app/data/models/address_model.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';

class MyAddressItem extends StatelessWidget {
  AddressModel? address;
  VoidCallback? onTapItem;
  VoidCallback? onPressedRemover;
  int? index;

  MyAddressItem(this.index,
      {Key? key, required this.address, this.onTapItem, this.onPressedRemover})
      : super(key: key);

  Widget _getItemUI(BuildContext context) {
    double width = WidgetSizeConfig.screenWidth!;

    return AnimationConfiguration.staggeredList(
      position: index!,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Container(
          margin: EdgeInsets.only(bottom: width / 20),
          height: width / 2.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    address?.address ?? '',
                    textScaleFactor: width * .0040,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                ),
              ),
              if (onPressedRemover != null)
                Expanded(
                  child: TextButton(
                    onPressed: onPressedRemover,
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    return GestureDetector(
      onTap: onTapItem,
      child: _getItemUI(context),
    );
  }
}
