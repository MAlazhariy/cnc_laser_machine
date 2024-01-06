import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/provider/dashboard_provider.dart';
import 'package:elaser/utils/constants.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:elaser/view/base/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PrintResult extends StatefulWidget {
  const PrintResult({super.key});

  @override
  State<PrintResult> createState() => _PrintResultState();
}

class _PrintResultState extends State<PrintResult> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'convert_picture_description'.tr(),
                style: kMediumFontStyle,
                textAlign: TextAlign.center,
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
              const Spacer(),
              MainButton(
                title: 'next'.tr(),
                onPressed: () {
                  Provider.of<DashboardProvider>(context, listen: false).goToNextIndex();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
