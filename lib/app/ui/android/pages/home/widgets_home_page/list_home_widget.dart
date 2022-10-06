// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
//
// class ListHomeWidget extends StatelessWidget {
//   const ListHomeWidget({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetSizeConfig().init(context);
//
//     double width = WidgetSizeConfig.screenWidth!;
//     double height = WidgetSizeConfig.screenHeight!;
//     return Scaffold(
//         appBar: AppBar(
//             title: const Text("Text"),
//             centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light),
//         body: AnimationLimiter(
//           child: ListView.builder(
//             padding: EdgeInsets.all(width / 30),
//             physics:
//             const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             itemCount: 20,
//             itemBuilder: (BuildContext context, int index) {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 delay: const Duration(milliseconds: 100),
//                 child: SlideAnimation(
//                   duration: const Duration(milliseconds: 2500),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   horizontalOffset: -300,
//                   verticalOffset: -850,
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: width / 20),
//                     height: width / 4,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 40,
//                           spreadRadius: 10,
//                         ),
//                       ],
//                     ), child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.blue.withOpacity(.1),
//                         radius: width / 15,
//                         child: FlutterLogo(size: 30),
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         width: width / 2,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Example',
//                               textScaleFactor: 1.6,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black.withOpacity(.7),
//                               ),
//                             ),
//                             Text(
//                               'Example',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black.withOpacity(.8),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.navigate_next_outlined)
//                     ],
//                   ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         )
//     );
//   }
// }
