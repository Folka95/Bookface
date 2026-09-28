import 'package:blog_app/shared/data/gender_data.dart';
import 'package:blog_app/shared/data/interests_data.dart';

class MyUserData {
  final String? email;

  final String? name;
  final String? profileImage;

  final String? about;
  final GenderItem? gender;
  final String? nationality;
  final List<InterestItem>? interests;
  final DateTime? birthdate;

  final DateTime? createdAt;
  final DateTime? lastActive;

  const MyUserData({
    this.name,
    this.email,
    this.profileImage,
    this.about,
    this.gender,
    this.nationality,
    this.interests,
    this.birthdate,
    this.createdAt,
    this.lastActive,
  });

  MyUserData copyWith({
    String? email,
    String? name,
    String? profileImage,
    String? about,
    GenderItem? gender,
    String? nationality,
    List<InterestItem>? interests,
    DateTime? birthdate,
    DateTime? createdAt,
    DateTime? lastActive,
  }) {
    return MyUserData(
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      about: about ?? this.about,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      interests: interests ?? this.interests,
      birthdate: birthdate ?? this.birthdate,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }

  factory MyUserData.fromJson(Map<String, dynamic> json) {
    return MyUserData(
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      about: json['about'],
      gender: json['gender'] != null
          ? GenderItem.fromJson(json['gender'])
          : null,
      nationality: json['country'],
      interests: json['interests'] != null
          ? (json['interests'] as List)
          .map((e) => InterestItem.fromJson(e))
          .toList()
          : null,
      birthdate: json['birthdate'] != null && json['birthdate'] != ''
          ? DateTime.parse(json['birthdate'])
          : null,
      createdAt: json['createdAt'] != null && json['createdAt'] != ''
          ? DateTime.parse(json['createdAt'])
          : null,
      lastActive: json['lastActive'] != null && json['lastActive'] != ''
          ? DateTime.parse(json['lastActive'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'about': about,
      'gender': gender?.toJson(),
      'country': nationality,
      'interests': interests?.map((e) => e.toJson()).toList(),
      'birthdate': birthdate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'lastActive': lastActive?.toIso8601String(),
    };
  }
}