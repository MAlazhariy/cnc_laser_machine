
import 'package:connection_wrapper/connection_wrapper.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:elaser/utils/languages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:elaser/helper/router_helper.dart';
import 'package:elaser/my_app.dart';
import 'package:elaser/utils/di_container.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // localization
  await EasyLocalization.ensureInitialized();

  // init routes
  RouterHelper.init();

  // init singleton
  await Di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Di.sl<SplashProvider>()),
      ],
      child: EasyLocalization(
        supportedLocales: Language.locales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        /// The package [ConnectionWrapper] implemented by [MAlazhariy].
        /// It didn't good finished as a clean code & best performance
        /// because of time.
        /// So I included the package into a project, and will work on it soon.
        ///
        /// You can find me out on the GitHub from this link: https://github.com/MAlazhariy
        child: ConnectionWrapper.init(
          disconnectionOptions: DisconnectionOptions(
            title: 'no_internet'.tr(),
            tryAgain: 'try_again'.tr(),
          ),
          child: const MyApp(),
        ),
      ),
    ),
  );
}
