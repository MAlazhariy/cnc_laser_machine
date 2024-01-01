import 'package:connection_wrapper/connection_wrapper.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/view/base/alert_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
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
      init();
    });
  }

  Future<void> init() async {
    if (!mounted) return;
    // final responseModel = await Provider.of<SplashProvider>(context, listen: false).getConfig();
    //
    // if (responseModel.isSuccess) {
    //   _onSuccessConfig();
    // } else {
    //   if (!mounted) return;
    //   _onFailedConfig(context, responseModel.message!);
    // }
  }

  Future<void> _onSuccessConfig() async {
    if (!mounted) return;

    // // set navigation route name
    // if (config.forceUpdate) {
    //   screenRoute = Routes.getUpdateAppScreen(isUpdate: true);
    // } else if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn) {
    //   screenRoute = Routes.getDashboardScreen();
    // } else if (Provider.of<SplashProvider>(context, listen: false).isFirstOpen && false) {
    //   // todo: handle onBoardingScreen
    //   screenRoute = Routes.getOnBoardScreen();
    // } else {
    //   screenRoute = Routes.getLoginScreen();
    // }

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    // TODO: Go to screen
  }

  void _onFailedConfig(BuildContext context, String errorMsg) {
    /// quit if not mounted or is there no internet connection
    if (!mounted) return;
    showErrorDialog(
      context: context,
      description: errorMsg,
      buttons: [
        MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                init();
              });
            },
            child: Text(
              "try_again".tr(),
            )),
      ],
    );
    // SnkBar.showError(context, errorMsg);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionWrapperWidget(
      onRestoreInternetConnection: init,
      child: Scaffold(
        backgroundColor: kScaffoldBG,
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDefault,
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'E-Laser',
                style: kExtraBoldFontStyle.copyWith(
                  fontSize: AppSize.fontExtraLarge-2,
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
