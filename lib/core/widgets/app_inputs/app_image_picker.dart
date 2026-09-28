import 'dart:io';
import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AppImagePicker extends StatefulWidget {
  final void Function(File?) onImageChanged;
  File? selectedImage;
  //Widget defaultImage;

  AppImagePicker({
    required this.onImageChanged,
   // required this.defaultImage,
    Key? key
  }) : super(key: key);

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<AppImagePicker> {

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      widget.onImageChanged(File(pickedFile.path));
      setState(() {
        widget.selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          widget.selectedImage != null
              ? Image.file(widget.selectedImage!, height: 200, width: 200, fit: BoxFit.cover)
          :
              CircleAvatar(
                radius: 100,
                backgroundColor: Color(0xFFEFEAE3),
                child:  Icon(
                    Icons.person_rounded,
                    size: 50,
                  color: Color(0xFF9C948A),
                ),
              ),
          //     : Container(
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
          // ),

          InkWell(
            onTap: () {
              _pickImage(context);
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xFF2F6F62),
                border: BoxBorder.all(
                  color: Color(0xFFF7F5F1),
                  strokeAlign: 0,
                  style: BorderStyle.solid,
                  width: 2,
                )
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}