import 'package:blog_app/core/widgets/app_inputs/app_date_picker.dart';
import 'package:blog_app/core/widgets/app_inputs/app_drop_down.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/input/app_gender_selector.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:flutter/material.dart';
import 'package:world_flags/world_flags.dart';

class UserDataFormPersonalDetailsSection extends StatelessWidget {
  final void Function(DateTime?) onBirthdateChanged;
  final void Function(GenderItem?) onGenderChanged;
  final void Function(String) onNationalityChanged;

  final String birthdateError;
  final String genderError;
  final String nationalityError;

  final DateTime? birthdate;
  final GenderItem? gender;
  final String nationality;

  final double itemSpacing;
  final double subinfoFontSize;
  final double sectionFontSize;
  final double fieldFontSize;

  const UserDataFormPersonalDetailsSection({
    super.key,
    required this.onBirthdateChanged,
    required this.onGenderChanged,
    required this.onNationalityChanged,

    required this.birthdateError,
    required this.genderError,
    required this.nationalityError,

    required this.birthdate,
    required this.gender,
    required this.nationality,

    required this.itemSpacing,
    required this.subinfoFontSize,
    required this.fieldFontSize,
    required this.sectionFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: itemSpacing,
      children: [
        Text(
          'PERSONAL DETAILS',
          style: TextStyle(
            fontSize: sectionFontSize,
            color: Color(0xFF8A8177),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Birthdate',
              style: TextStyle(
                fontSize: fieldFontSize,
                color: Color(0xFF4A453F),
              ),
            ),
            AppDatePicker(
              onBirthdateChanged: onBirthdateChanged,
              selectedDate: birthdate,
              error: birthdateError,
            ),
          ],
        ),

        Column(
          spacing: itemSpacing,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: fieldFontSize,
                    color: Color(0xFF4A453F),
                  ),
                ),
                AppGenderSelector(
                  onGenderChanged: onGenderChanged,
                  selectedGender: gender,
                  error: genderError,
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nationality',
                  style: TextStyle(
                    fontSize: fieldFontSize,
                    color: Color(0xFF4A453F),
                  ),
                ),
                AppDropDown<String>(
                  onSelectionChanged: onNationalityChanged,
                  items: _getCountryItems(),
                  selectedItem: nationality,
                  error: nationalityError,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<DropDownItem<String>> _getCountryItems() {
    const _items = <IsoTranslated, BasicFlag>{
      ...smallSimplifiedFlagsMap,
      ...smallSimplifiedCurrencyFlagsMap,
      ...smallSimplifiedLanguageFlagsMap,
    };

    final countryValues = _items.entries
        .map((entry) {
      final item = entry.key;

      return DropDownItem<String>(
        name: item.internationalName,
        prefixImg: IsoFlag(
          item,
          _items,
          height: 24,
        ),
        value: item.internationalName,
      );
    })
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return countryValues;
  }
}