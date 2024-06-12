import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/provider/laser_provider.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/view/base/custom_dialog.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:elaser/view/base/main_circular_progress_adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('laser_engraving'.tr()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Consumer<LaserProvider>(
            builder: (context, laserProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (laserProvider.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LinearProgressIndicator(),
                    ),
                  Text(
                    (laserProvider.isLoading ? 'sending_file_to_machine' : 'file_sent').tr(),
                    style: kMediumFontStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: StreamBuilder(
                      stream: laserProvider.progressStream,
                      builder: (context, snapshot) {
                        if (laserProvider.isLoading) {
                          return const Center(
                            child: MainCircularProgress(),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  MainButton(
                    title: 'send_engraving_command'.tr(),
                    color: kMainColor,
                    onPressed: laserProvider.isLoading
                        ? null
                        : () async {
                            final response = await laserProvider.sendFileToFirebase();
                            if (response.isSuccess) {
                              Fluttertoast.showToast(
                                msg: "The operation was successful",
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
                                    // color: kWrongAnswerColor,
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
