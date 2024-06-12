// import 'package:easy_localization/easy_localization.dart';
// import 'package:elaser/provider/laser_provider.dart';
// import 'package:elaser/provider/splash_provider.dart';
// import 'package:elaser/utils/resources/app_text_styles.dart';
// import 'package:elaser/utils/resources/color_manager.dart';
// import 'package:elaser/view/base/custom_dialog.dart';
// import 'package:elaser/view/base/main_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
//
// class LaserEngraving extends StatefulWidget {
//   const LaserEngraving({super.key});
//
//   @override
//   State<LaserEngraving> createState() => _LaserEngravingState();
// }
//
// class _LaserEngravingState extends State<LaserEngraving> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('laser_engraving'.tr()),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(22),
//           child: Consumer<LaserProvider>(
//             builder: (context, laserProvider, _) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (laserProvider.isLoading)
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 12),
//                       child: LinearProgressIndicator(),
//                     ),
//                   Text(
//                     (laserProvider.connectedToMachine ? 'connected_to_machine' : 'disconnected_to_machine').tr(),
//                     style: kMediumFontStyle.copyWith(
//                       color: laserProvider.connectedToMachine ? kCorrectAnswerColor : Colors.grey,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 12),
//                   Expanded(
//                     child: StreamBuilder(
//                       stream: laserProvider.progressStream,
//                       builder: (context, snapshot) {
//                         if (laserProvider.connectedToMachine) {
//                           return Center(
//                             child: Text(
//                               '${snapshot.data?.toStringAsFixed(1) ?? 0}%',
//                               style: kBoldFontStyle.copyWith(
//                                 color: laserProvider.connectedToMachine ? kMainColor : Colors.grey,
//                                 fontSize: 50,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           );
//                         }
//
//                         return const SizedBox.shrink();
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   MainButton(
//                     title: 'send_engraving_command'.tr(),
//                     color: laserProvider.connectedToMachine ? Colors.redAccent : kMainColor,
//                     onPressed: laserProvider.isLoading
//                         ? () async {
//                             await laserProvider.cancelConnection();
//                           }
//                         : () async {
//                             final host = Provider.of<SplashProvider>(context, listen: false).ipAddress!;
//                             final port = Provider.of<SplashProvider>(context, listen: false).port!;
//                             final response = await laserProvider.sendFileToCNC(host, port);
//                             if (response.isSuccess) {
//                               Fluttertoast.showToast(
//                                 msg: "The operation was successful",
//                                 backgroundColor: kCorrectAnswerColor,
//                               );
//                             } else {
//                               if (!mounted) return;
//                               showCustomDialog(
//                                 context: context,
//                                 title: '${'error_occurred'.tr()} ${response.code ?? ''}',
//                                 description: '${response.message}',
//                                 backgroundColor: kWrongAnswerColor,
//                                 buttons: [
//                                   DialogButton(
//                                     title: 'Copy Error',
//                                     // color: kWrongAnswerColor,
//                                     onPressed: () async {
//                                       await Clipboard.setData(ClipboardData(text: '${response.message}'));
//                                       if (!mounted) return;
//                                       Navigator.pop(context);
//                                     },
//                                   ),
//                                 ],
//                               );
//                             }
//                           },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
