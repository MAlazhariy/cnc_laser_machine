import 'package:elaser/data/model/language_model.dart';
import 'package:elaser/utils/languages.dart';
import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/utils/routes.dart';
import 'package:elaser/view/base/main_button.dart';
import 'package:elaser/view/base/snk_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String? _selectedLang;
  final List<LanguageModel> _languages = Language.languages;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  void _init() {
    _selectedLang = context.locale.toString();
    setState(() {});
  }

  Future<void> _onChangeLanguage(BuildContext context) async {
    await Language.changeLanguage(context, locale: Locale(_selectedLang!));
    if (!mounted) return;
    SnkBar.showSuccess(context, 'language_changed_success'.tr());
    await Navigator.pushNamedAndRemoveUntil(context, Routes.getDashboardScreen(), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'change_language'.tr(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.large),
            Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.paddingLarge,
              ),
              child: Text(
                'select_language'.tr(),
                style: kBoldFontStyle,
              ),
            ),

            const SizedBox(height: AppSize.large),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: _languages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final lang = _languages[index];

                            return _languageWidget(
                              context: context,
                              isSelected: _selectedLang == lang.languageCode,
                              languageModel: lang,
                              index: index,
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ),

            // save button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.paddingExtraLarge,
                vertical: AppSize.paddingDefault,
              ),
              child: MainButton(
                title: 'save'.tr(),
                onPressed: _selectedLang != null && _selectedLang != context.locale.toString()
                    ? () async {
                        _onChangeLanguage(context);
                      }
                    : null,
                fit: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageWidget({
    required bool isSelected,
    required BuildContext context,
    required LanguageModel languageModel,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        if (_selectedLang != languageModel.languageCode) {
          setState(() {
            _selectedLang = languageModel.languageCode;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? kMainColor.withOpacity(.15) : null,
          border: Border(
              top: BorderSide(width: 1.0, color: isSelected ? kMainColor : Colors.transparent),
              bottom: BorderSide(width: 1.0, color: isSelected ? kMainColor : Colors.transparent)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: isSelected ? Colors.transparent : kGreyTextColor.withOpacity(.3))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // language with flag
              Row(
                children: [
                  Image.asset(languageModel.imagePath, width: 34, height: 34),
                  const SizedBox(width: 30),
                  Text(
                    languageModel.languageName,
                    style: kBoldFontStyle,
                  ),
                ],
              ),
              isSelected
                  ? const Icon(
                      Icons.check,
                      size: AppSize.extraLarge,
                      color: kMainColor,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
