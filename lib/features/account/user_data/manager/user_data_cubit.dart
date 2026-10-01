import 'dart:convert';
import 'dart:io';

import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/core/widgets/app_inputs/app_drop_down.dart';
import 'package:bloc/bloc.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:blog_app/shared/data/interests_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';


part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final bool isSignup;
  final String userId;
  final String? userEmail;

  UserDataCubit({
    required this.isSignup,
    required this.userId,
    required this.userEmail,
  }) : super(UserDataInitial());



  Future<void> load() async {
    emit(UserDataLoading());
    if (isSignup) {
      emit(UserDataLoaded(
        user: MyUserData(),
        firstLoad: true,
      ));
      return;
    }
    try {
      final db = FirebaseFirestore.instance;
      final doc = await db
          .collection("users")
          .doc(userId)
          .get();
      final data = MyUserData.fromJson(
        doc.data()!,
      );
      emit(UserDataLoaded(
          user: data,
          firstLoad: true,
      ));
    } catch (e) {
      emit(UserDataFailure(message: e.toString()));
    }
  }

  Future<String> _uploadProfilePhoto(File profilePhoto) async {
    final bytes = await profilePhoto.readAsBytes();

    final fileName = profilePhoto.path
        .split(Platform.pathSeparator)
        .last;

    final response = await Dio().post(
      'https://script.google.com/macros/s/AKfycbyX1JZ7IkywvEPqItGK61WC8M05kWgwgovtcj-Mjrzyrbt_QsAnSA0CRQp-af6_G7nX/exec',
      data: {
        'imageName': fileName,
        'mimeType': 'image/jpeg',
        'image': base64Encode(bytes),
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.plain,
      ),
    );

    return response.data.toString();
  }

  Future<void> _saveSignup({
    required String name,
    required String about,
    required DateTime birthdate,
    required GenderItem gender,
    required String nationality,
    required List<InterestItem> interests,
    required File? profilePhoto,
  }) async {
    try {
      var data = MyUserData(
        name: name,
        about: about,
        birthdate: birthdate,
        gender: gender,
        nationality: nationality,
        interests: interests,
      );

      if (profilePhoto != null) {
        // data = data.copyWith(
        //   profileImage: await _uploadProfilePhoto(profilePhoto),
        // );
      }

      if (userEmail == null) {
        throw Exception('User email is null');
      }

      data = data.copyWith(
        email: userEmail,
      );

      final db = FirebaseFirestore.instance;

      await db.collection("users").doc(userId).set(
        data.copyWith(
          createdAt: DateTime.now(),
        ).toJson(),
      );

      emit(UserDataCompleted());
    } catch (e) {
      emit(UserDataFailure(message: e.toString()));
    }
  }

  Future<void> _saveEdit({
    required String name,
    required String about,
    required DateTime birthdate,
    required GenderItem gender,
    required String nationality,
    required List<InterestItem> interests,
    required File? profilePhoto,
  }) async {
    try {
      final db = FirebaseFirestore.instance;

      final doc = await db
          .collection("users")
          .doc(userId)
          .get();

      if (!doc.exists || doc.data() == null) {
        emit(UserDataLoggedOut());
        return;
      }

      final oldData = MyUserData.fromJson(
        doc.data()!,
      );

      String? profileImage = oldData.profileImage;

      if (profilePhoto != null) {
        profileImage = await _uploadProfilePhoto(profilePhoto);
      }

      final newData = oldData.copyWith(
        name: name,
        about: about,
        birthdate: birthdate,
        gender: gender,
        nationality: nationality,
        interests: interests,
        profileImage: profileImage,
      );

      await db.collection("users").doc(userId).set(newData.toJson());

      await UserDataCache.save(newData);

      emit(UserDataSaved());
    } catch (e) {
      emit(UserDataFailure(message: e.toString()));
    }
  }

  Future<void> save({
    required String name,
    required String about,
    required DateTime birthdate,
    required GenderItem gender,
    required String nationality,
    required List<InterestItem> interests,
    required File? profilePhoto,
  }) async {
    emit(UserDataSaving());
    if (isSignup) {
      await _saveSignup(
        name: name,
        about: about,
        birthdate: birthdate,
        gender: gender,
        nationality: nationality,
        interests: interests,
        profilePhoto: profilePhoto,
      );
    }
    else {
      await _saveEdit(
        name: name,
        about: about,
        birthdate: birthdate,
        gender: gender,
        nationality: nationality,
        interests: interests,
        profilePhoto: profilePhoto,
      );
    }
  }

  bool validate({
    required String? name,
    required String? about,
    required DateTime? birthdate,
    required GenderItem? gender,
    required String? nationality,
    required List<InterestItem>? interests,
    required File? profilePhoto,
  }) {
    String birthdateError = "";
    String genderError = "";
    String interestsError = "";
    String nationalityError = "";

    if (birthdate == null) {
      birthdateError = 'Please select your birthdate';
    } else {
      final today = DateTime.now();

      var age = today.year - birthdate.year;

      if (today.month < birthdate.month ||
          (today.month == birthdate.month &&
              today.day < birthdate.day)) {
        age--;
      }

      if (age < 18) {
        birthdateError = 'You must be at least 18 years old';
      }
    }

    if (gender == null) {
      genderError = 'Please select your gender';
    }

    if (interests == null || interests.length < 2) {
      interestsError = 'Please select at least 2 interests';
    }

    if (nationality == null || nationality.isEmpty) {
      nationalityError = 'Please select your nationality';
    }

    final hasError =
        birthdateError.isNotEmpty ||
            genderError.isNotEmpty ||
            interestsError.isNotEmpty ||
            nationalityError.isNotEmpty;

    if (hasError) {
      emit(
        UserDataLoaded(
          user: null,
          firstLoad: false,
          isBirthdateError: birthdateError,
          isGenderError: genderError,
          isInterestsError: interestsError,
          isNationalityError: nationalityError,
        ),
      );

      return false;
    }

    return true;
  }
}


