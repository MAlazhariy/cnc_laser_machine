import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/helper/navigation/push_and_finish.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:elaser/view/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController ipAddressController = TextEditingController();
  TextEditingController portController = TextEditingController();

  void _saveSettings() async {
    String ipAddress = ipAddressController.text;
    String port = portController.text;

    // save data
    await Provider.of<SplashProvider>(context, listen: false).saveConfigData(ipAddress: ipAddress, port: port);
    if (!mounted) return;

    // back
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      pushAndFinish(context, const DashboardScreen());
    }
  }

  bool get isDataChanged {
    final ipAddress = ipAddressController.text.isNotEmpty
        ? ipAddressController.text
        : Provider.of<SplashProvider>(context, listen: false).ipAddress;
    final port = portController.text.isNotEmpty
        ? portController.text
        : Provider.of<SplashProvider>(context, listen: false).port;

    return ipAddress?.isNotEmpty == true && port?.isNotEmpty == true;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('IP Address', style: kBoldFontStyle),
            TextField(
              controller: ipAddressController,
              decoration: InputDecoration(hintText: Provider.of<SplashProvider>(context, listen: false).ipAddress ?? 'Enter IP Address'),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() { });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Port', style: kBoldFontStyle),
            TextField(
              controller: portController,
              decoration: InputDecoration(hintText: Provider.of<SplashProvider>(context, listen: false).port ?? "Enter Port"),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() { });
              },
            ),
            const SizedBox(height: 32.0),
            Consumer<SplashProvider>(
              builder: (context, splashProvider, _) {
                return MainButton(
                  onPressed: isDataChanged ? _saveSettings : null,
                  title: 'save'.tr(),
                  loading: splashProvider.isLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
