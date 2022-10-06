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
    double height = WidgetSizeConfig.screenHeight!;
    return
      AnimationConfiguration.staggeredList(
        position: index!,
        delay: const Duration(milliseconds: 100),
        child: SlideAnimation(
          duration: const Duration(milliseconds: 2500),
          curve: Curves.fastLinearToSlowEaseIn,
          // horizontalOffset: -300,
          // verticalOffset: -850,
          child: Container(
            margin: EdgeInsets.only(bottom: width / 20),
            height: width / 2,
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
                    child:
                        Padding(padding: EdgeInsets.only(left: 10),child:
           //     Container(
              //    alignment: Alignment.center,
                //  width: width / 2,
                 // child: Column(
                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   // crossAxisAlignment: CrossAxisAlignment.start,
                  //  children: [
                      Text(
                     address?.address??'',
                        textScaleFactor: width *.0040,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),

                 //   ],
                //  ),
                ),  ),
        //  ),
                if (onPressedRemover != null)
                                Expanded(
                                  child: TextButton(
                                    onPressed: onPressedRemover,
                                    child: const Text('Delete',style: TextStyle(color: Colors.red,fontSize: 15),),
                                  ),
                                )
              ],
            ),
          ),
        ),
      );}









    //   Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: Card(
    //     child: Row(
    //       children: <Widget>[
    //         SizedBox(
    //           width: SizeConfig.screenWidth! * .30,
    //           height: SizeConfig.screenHeight! * .15,
    //           child: Image.network(
    //             address!.photoCountry[0],
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Expanded(
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       textNamePlace('País: ${address?.country ?? ''}'),
    //                       subTextNamePlace('Estado: ${address?.state ?? ""}'),
    //                       subTextNamePlace('Cidade: ${address?.city ?? ""}'),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               if (onPressedRemover != null)
    //                 Expanded(
    //                   child: TextButton(
    //                     onPressed: onPressedRemover,
    //                     child: const Text('Delete'),
    //                   ),
    //                 )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );


  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    return GestureDetector(
      onTap: onTapItem,
      child: _getItemUI(context),
    );
  }
}
