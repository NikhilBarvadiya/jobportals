import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:jobportals/core/constants/app_text.dart';
import 'package:jobportals/core/helpers/common_helper.dart';
import 'package:jobportals/core/helpers/decoration.dart';

class DocumentPicker extends StatefulWidget {
  const DocumentPicker({super.key, required this.title, required this.image});

  final String title;
  final Function(dio.FormData) image;

  @override
  State<DocumentPicker> createState() => _DocumentPickerState();
}

class _DocumentPickerState extends State<DocumentPicker> {
  File? file;

  @override
  void initState() {
    imagesValidation();
    super.initState();
  }

  imagesValidation() {
    if (file != null) {
      return file!.path;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf3f5f7),
        borderRadius: decoration.allBorderRadius(10.0),
        border: Border.all(color: Colors.transparent),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
              ),
              Text(
                AppText.documentPickerNot,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              )
            ],
          ),
          file == null && imagesValidation() == null
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: decoration.allBorderRadius(10.0),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      commonHelper.pickImage(ImageSource.gallery).then((value) {
                        value != null ? file = value : null;
                        _setImage();
                      });
                    },
                    padding: EdgeInsets.zero,
                    minWidth: 50,
                    shape: RoundedRectangleBorder(borderRadius: decoration.allBorderRadius(10.0)),
                    child: Icon(Icons.camera_alt_rounded, size: 20, color: Colors.grey.shade400),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    commonHelper.pickImage(ImageSource.gallery).then((value) {
                      value != null ? file = value : null;
                      _setImage();
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: decoration.allBorderRadius(10.0),
                      image: DecorationImage(image: FileImage(File(imagesValidation())), fit: BoxFit.cover),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _setImage() async {
    if (file != null) {
      dio.FormData fromData = dio.FormData();
      String path = file!.path;
      String imageName = file!.path.split('/').last;
      fromData.files.add(
        MapEntry(
          "images",
          await dio.MultipartFile.fromFile(path, filename: imageName.toString()),
        ),
      );
      widget.image(fromData);
      setState(() {});
    }
  }
}
