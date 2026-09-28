import 'dart:io';

import 'package:blog_app/core/widgets/app_inputs/app_image_picker.dart';
import 'package:flutter/material.dart';

class UserDataFormProfileSection extends StatelessWidget {
  final void Function(File?) onImageChanged;
  final double itemSpacing;
  final double subinfoFontSize;

  UserDataFormProfileSection({
      required this.onImageChanged,
      required this.itemSpacing,
      required this.subinfoFontSize,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: itemSpacing,
      children: [
        AppImagePicker(
          onImageChanged: onImageChanged,
            // defaultImage: Container(
            //   width: 100.0,
            //   height: 100.0,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xFFEFEAE3),
            //   ),
            //   child: Icon(
            //     Icons.person_rounded,
            //     size: 50,
            //     color: Color(0xFF9C948A),
            //   ),
            // )


        ),
        Text(
          'Tap to add a photo',
          style: TextStyle(
            fontSize: subinfoFontSize,
            color: Color(0xFF6B6560),
          ),
        ),
      ],
    );
  }
}

