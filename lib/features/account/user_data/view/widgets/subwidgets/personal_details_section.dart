import 'dart:io';

import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:blog_app/core/helpers/validators.dart';
import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/input/app_interests_selector.dart';
import 'package:blog_app/core/widgets/app_inputs/app_date_picker.dart';
import 'package:blog_app/core/widgets/app_inputs/app_drop_down.dart';
import 'package:blog_app/core/widgets/app_inputs/app_form_field.dart';
import 'package:blog_app/core/widgets/app_inputs/app_image_picker.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/input/app_gender_selector.dart';
import 'package:blog_app/features/account/user_data/manager/user_data_cubit.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_flags/world_flags.dart';


class UserDataFormPersonalDetailsSection extends StatelessWidget {
  final void Function(DateTime?) onBirthdateChanged;
  final void Function(GenderItem?) onGenderChanged;
  final void Function(String) onNationalityChanged;

  DateTime? birthdate;
  GenderItem? gender;
  String nationality;

  final double itemSpacing;
  final double subinfoFontSize;
  final double sectionFontSize;
  final double fieldFontSize;

  UserDataFormPersonalDetailsSection({
    required this.onBirthdateChanged,
    required this.onGenderChanged,
    required this.onNationalityChanged,

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
                )
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
                )
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

