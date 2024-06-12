import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/provider/laser_provider.dart';
import 'package:elaser/utils/constants.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/view/base/custom_dialog.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConvertPicWebViewScreen extends StatefulWidget {
  const ConvertPicWebViewScreen({super.key});

  @override
  State<ConvertPicWebViewScreen> createState() => _ConvertPicWebViewScreenState();
}

class _ConvertPicWebViewScreenState extends State<ConvertPicWebViewScreen> {
  FilePickerResult? filePickerResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('convert_picture'.tr()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<LaserProvider>(
                        builder: (context, laserProvider, _){
                          if(laserProvider.isLoading) {
                            return const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: LinearProgressIndicator(),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                      Text(
                        'convert_picture_description'.tr(),
                        style: kMediumFontStyle,
                      ),
                      const SizedBox(height: 8),
                      MainButton(
                        title: 'convert_picture'.tr(),
                        outlined: true,
                        onPressed: () {
                          launchUrlString(
                            AppConstants.convertPicSiteUrl,
                            mode: LaunchMode.inAppBrowserView,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(
                        'pick_file_description'.tr(),
                        style: kMediumFontStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      MainButton(
                        title: 'pick_file'.tr(),
                        outlined: true,
                        onPressed: () async {
                          await Provider.of<LaserProvider>(context, listen: false).pickFile();
                          if(!mounted) return;
                          if(!Provider.of<LaserProvider>(context, listen: false).isFileValid){
                            showCustomDialog(
                              context: context,
                              title: 'invalid_picked_file'.tr(),
                              description: 'pick_file_description'.tr(),
                              backgroundColor: kWrongAnswerColor,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: 'success_picked_file'.tr(),
                              backgroundColor: kSuccessColor,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              // MainButton(
              //   title: 'next'.tr(),
              //   onPressed: Provider.of<LaserProvider>(context, listen: true).isFileValid
              //       ? () {
              //           if (Provider.of<LaserProvider>(context, listen: false).isFileValid) {
              //             Provider.of<DashboardProvider>(context, listen: false).goToNextIndex();
              //           } else {
              //             Fluttertoast.showToast(
              //               msg: 'invalid_picked_file'.tr(),
              //               backgroundColor: kWrongAnswerColor,
              //               toastLength: Toast.LENGTH_LONG,
              //             );
              //           }
              //         }
              //       : null,
              // ),
              Consumer<LaserProvider>(
                builder: (context, laserProvider, _){
                  return MainButton(
                    title: laserProvider.isLoading ? 'sending_file_to_machine'.tr() : 'send_engraving_command'.tr(),
                    color: kMainColor,
                    onPressed: laserProvider.isLoading || !Provider.of<LaserProvider>(context, listen: true).isFileValid
                        ? null
                        : () async {
                      final response = await laserProvider.sendFileToFirebase();
                      if (response.isSuccess) {
                        Fluttertoast.showToast(
                          msg: "file_sent".tr(),
                          backgroundColor: kCorrectAnswerColor,
                        );
                      } else {
                        if (!context.mounted) return;
                        showCustomDialog(
                          context: context,
                          title: '${'error_occurred'.tr()} ${response.code ?? ''}',
                          description: '${response.message}',
                          backgroundColor: kWrongAnswerColor,
                          buttons: [
                            DialogButton(
                              title: 'Copy Error',
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(text: '${response.message}'));
                                if (!context.mounted) return;
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
