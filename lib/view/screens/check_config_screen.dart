import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/helper/navigation/push.dart';
import 'package:elaser/provider/dashboard_provider.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:elaser/view/screens/connection_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckConfigScreen extends StatefulWidget {
  const CheckConfigScreen({super.key});

  @override
  State<CheckConfigScreen> createState() => _CheckConfigScreenState();
}

class _CheckConfigScreenState extends State<CheckConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('check_settings'.tr()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'check_settings_description'.tr(),
                style: kMediumFontStyle,
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'IP Address: ${Provider.of<SplashProvider>(context, listen: false).ipAddress ?? '?'}\n'
                'Port: ${Provider.of<SplashProvider>(context, listen: false).port ?? '?'}',
                style: kMediumFontStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 22),
              /*MainButton(
                // todo: handle wifi connect
                title: 'connect_wifi'.tr(),
                outlined: true,
                onPressed: () {
                  // pushTo(context, const ConnectionSettingsScreen());
                },
              ),*/
              const SizedBox(height: 12),
              MainButton(
                title: 'connection_settings'.tr(),
                outlined: true,
                onPressed: () {
                  pushTo(context, const ConnectionSettingsScreen());
                },
              ),
              // const SizedBox(height: 50),
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
