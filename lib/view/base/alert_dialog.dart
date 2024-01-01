import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String description,
  String? title,
  IconData icon = Icons.error_outline,
  List<Widget> buttons = const <Widget>[],
}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.paddingDefault,
                  horizontal: AppSize.paddingSmall-2,
                ),
                decoration: const BoxDecoration(
                  color: kWrongAnswerColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
              ),

              // alert widget
              SingleChildScrollView(
                // physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? 'error_occurred'.tr(),
                        style: const TextStyle(
                          color: kWrongAnswerColor,
                          fontWeight: FontWeight.w900,
                          fontSize: AppSize.large,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.small,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          // color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: AppSize.defaultSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Wrap(
                spacing: AppSize.extraSmall,
                children: buttons,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
    },
  );
}
