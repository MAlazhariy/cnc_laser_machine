import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/helper/navigation/push_and_finish.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:elaser/view/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ConnectionSettingsScreen extends StatefulWidget {
  const ConnectionSettingsScreen({super.key});

  @override
  State<ConnectionSettingsScreen> createState() => _ConnectionSettingsScreenState();
}

class _ConnectionSettingsScreenState extends State<ConnectionSettingsScreen> {
  final ipAddressController = TextEditingController();
  final portController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ipAddressController.text = Provider.of<SplashProvider>(context, listen: false).ipAddress ?? '';
      portController.text = Provider.of<SplashProvider>(context, listen: false).port ?? '';
      setState(() {});
    });
  }

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
    return portController.text.isNotEmpty && portController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('connection_settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('IP Address', style: kBoldFontStyle),
            TextField(
              controller: ipAddressController,
              decoration: const InputDecoration(hintText: 'Enter IP Address'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                // FilteringTextInputFormatter.allow(RegExp(r'^([0-9]{1,3}\.){0,3}[0-9]{0,3}$')),
                FilteringTextInputFormatter.deny(RegExp('[^0-9.]')), // Deny any character that is not a digit or dot
              ],
              onChanged: (_) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Port', style: kBoldFontStyle),
            TextField(
              controller: portController,
              decoration: const InputDecoration(hintText: "Enter Port"),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[^0-9]')),
              ],
              onChanged: (_) {
                setState(() {});
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
