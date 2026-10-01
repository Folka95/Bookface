import 'dart:io';

import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/features/account/user_data/manager/user_data_cubit.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/basic_info_section.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/interests_section.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/personal_details_section.dart';
import 'package:blog_app/features/account/user_data/view/widgets/subwidgets/profile_image_secion.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:blog_app/shared/data/interests_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataForm extends StatelessWidget {
  // Data
  final _formKey;

  // UI Values
  final double sectionFontSize = 13;
  final double fieldFontSize = 14;
  final double optionalFontSize = 11;
  final double subinfoFontSize = 10;

  final double sectionSpacing = 18;
  final double itemSpacing = 6;

  // Controllers
  File? profilePhotoController;

  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  DateTime? birthdate;
  GenderItem? gender;
  String nationality = "";
  List<InterestItem> interests = [];

  void selectBirthdate(DateTime? newDate) {
    birthdate = newDate;
  }

  void selectProfileImage(File? newImage) {
    profilePhotoController = newImage;
  }

  void selectGender(GenderItem? newGender) {
    gender = newGender;
  }

  void selectNationality(String newNationality) {
    nationality = newNationality;
  }


  UserDataForm({
    super.key,
    required this._formKey,
  });


  void _initializeValues(MyUserData? data) {
    if (data == null) {
      return;
    }
    nameController = TextEditingController(text: data.name ?? '');
    aboutController = TextEditingController(text: data.about ?? '');
    birthdate = data.birthdate;

    gender = data.gender;
    nationality = data.nationality ?? "";

    interests = data.interests ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoaded) {
          if(state.firstLoad) {
            _initializeValues(state.user);
          }
          return Form(
            key: _formKey,
            child: Container(
              color: Color(0xFFF7F5F1),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        spacing: sectionSpacing,
                        children: [
                          const SizedBox(),
                          UserDataFormProfileSection(
                            onImageChanged: selectProfileImage,
                            itemSpacing: itemSpacing,
                            subinfoFontSize: subinfoFontSize,
                          ),
                          UserDataFormBasicInfoSection(
                              nameController: nameController,
                              aboutController: aboutController,
                              sectionFontSize: sectionFontSize,
                              optionalFontSize: optionalFontSize,
                              itemSpacing: itemSpacing,
                              fieldFontSize: fieldFontSize
                          ),
                          UserDataFormPersonalDetailsSection(
                            onBirthdateChanged: selectBirthdate,
                            onGenderChanged: selectGender,
                            onNationalityChanged: selectNationality,
                            genderError: state.isGenderError,
                            birthdateError: state.isBirthdateError,
                            nationalityError: state.isNationalityError,
                            gender: gender,
                            nationality: nationality,
                            birthdate: birthdate,
                            itemSpacing: itemSpacing,
                            subinfoFontSize: subinfoFontSize,
                            fieldFontSize: fieldFontSize,
                            sectionFontSize: sectionFontSize,
                          ),
                          UserDataFormInterestsSection(
                              interests: interests,
                              subinfoFontSize: subinfoFontSize,
                              sectionFontSize: sectionFontSize,
                              optionalFontSize: optionalFontSize
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(3, 0),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &
                            context.read<UserDataCubit>().validate(
                              name: nameController.text,
                              about: aboutController.text,
                              birthdate: birthdate,
                              gender: gender,
                              nationality: nationality,
                              interests: interests,
                              profilePhoto: profilePhotoController,
                            )) {
                          context.read<UserDataCubit>().save(
                            name: nameController.text,
                            about: aboutController.text,
                            birthdate: birthdate!,
                            gender: gender!,
                            nationality: nationality,
                            interests: interests,
                            profilePhoto: profilePhotoController,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2F6F62),
                        foregroundColor: Colors.white,
                        elevation: 5,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12), // Rounded corners
                        ),
                      ),
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is UserDataLoading) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFFF7F5F1),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFF7F5F1),
        );
      },
    );
  }
}
