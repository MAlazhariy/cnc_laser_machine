import 'package:connection_wrapper/connection_wrapper.dart';
import 'package:elaser/helper/navigation/push_and_finish.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/view/screens/dashboard_screen.dart';
import 'package:elaser/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initData();
    });
  }

  Future<void> initData() async {
    if (!mounted) return;
    final hasData = Provider.of<SplashProvider>(context, listen: false).getConfig();
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    if(hasData){
      pushAndFinish(context, const DashboardScreen());
    } else {
      pushAndFinish(context, const SettingsScreen());
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionWrapperWidget(
      onRestoreInternetConnection: initData,
      child: Scaffold(
        backgroundColor: kScaffoldBG,
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          color: kMainColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDefault,
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'E-Laser',
                style: kExtraBoldFontStyle.copyWith(
                  fontSize: AppSize.fontExtraLarge +10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              const Spacer(),
              // loading progress
              Consumer<SplashProvider>(
                builder: (context, splashProvider, _) {
                  if (splashProvider.isLoading) {
                    return const SizedBox(
                      height: AppSize.paddingLarge,
                      width: AppSize.paddingLarge,
                      child: CircularProgressIndicator.adaptive(
                        // valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        // backgroundColor: Platform.isIOS ? Colors.white : null,
                        strokeWidth: 2.4,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: AppSize.paddingExtraLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
