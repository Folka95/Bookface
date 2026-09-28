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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataFormBasicInfoSection extends StatelessWidget {

  TextEditingController nameController;
  TextEditingController aboutController;

  final double sectionFontSize;
  final double optionalFontSize;
  final double itemSpacing;
  final double fieldFontSize;

  UserDataFormBasicInfoSection({
    required this.nameController,
    required this.aboutController,
    required this.sectionFontSize,
    required this.optionalFontSize,
    required this.itemSpacing,
    required this.fieldFontSize,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: itemSpacing,
      children: [
        Text(
          'BASIC INFO',
          style: TextStyle(
            fontSize: sectionFontSize,
            color: Color(0xFF8A8177),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full name',
              style: TextStyle(
                fontSize: fieldFontSize,
                color: Color(0xFF4A453F),
              ),
            ),
            AppFormField(
              hintText: "eg. Sara Ahmed",
              validator: Validators.nameValidation,
              controller: nameController,
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: fieldFontSize,
                    color: Color(0xFF4A453F),
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
            AppFormField(
              hintText: "Tell us about yourself...",
              maxLines: 3,
              controller: aboutController,
              maxLength: 150,
            ),
          ],
        )

      ],
    );
  }
}

