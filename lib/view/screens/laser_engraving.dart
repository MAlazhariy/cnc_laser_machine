import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/provider/dashboard_provider.dart';
import 'package:elaser/provider/laser_provider.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaserEngraving extends StatefulWidget {
  const LaserEngraving({super.key});

  @override
  State<LaserEngraving> createState() => _LaserEngravingState();
}

class _LaserEngravingState extends State<LaserEngraving> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('laser_engraving'.tr()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pick file'.tr(),
                style: kMediumFontStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              MainButton(
                title: 'pick file'.tr(),
                outlined: true,
                onPressed: () async {

                },
              ),
              const SizedBox(height: 8),
              const Spacer(),
              MainButton(
                title: 'send_engraving_command'.tr(),
                color: Colors.redAccent,
                onPressed: () {
                  Provider.of<LaserProvider>(context, listen: false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
