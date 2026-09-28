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
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/interests_section.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/personal_details_section.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/profile_image_secion.dart';
import 'package:blog_app/shared/data/interests_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataFormInterestsSection extends StatelessWidget {

  List<InterestItem> interests;

  final double subinfoFontSize;
  final double sectionFontSize;
  final double optionalFontSize;

  UserDataFormInterestsSection({
    required this.interests,
    required this.subinfoFontSize,
    required this.sectionFontSize,
    required this.optionalFontSize,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'INTERESTS',
              style: TextStyle(
                fontSize: sectionFontSize,
                color: Color(0xFF8A8177),
              ),
            ),
            Text(
              'Optional',
              style: TextStyle(
                fontSize: optionalFontSize,
                color: Color(0xFF4A453F),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsetsGeometry.fromLTRB(0, 3, 0, 3),
          child: Text(
            'Pick few things you enjoy',
            style: TextStyle(
              fontSize: subinfoFontSize,
              color: Color(0xFF4A453F),
            ),
          ),
        ),
        AppInterestsSelector(
            selectedInterests: interests,
            items: Interests.getAllItems()
        ),
      ],
    );
  }
}

