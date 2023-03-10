import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import '../functions.dart';

class TextFrom extends StatelessWidget {
  const TextFrom({
    Key? key,
    this.validator,
    this.icon,
    required this.label,
    this.onChange,
    this.keyboardType,
    this.controller,
    this.onFieldSubmitted,
    this.onTap,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final IconData? icon;
  final String label;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s8.w, vertical: AppSize.s8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Text(
              label,
              style: TextStyle(color: ColorManager.white, fontSize: 16.sp),
            ),
          ),
          TextFormField(
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChange,
            style: TextStyle(fontSize: AppSize.s16.sp),
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorManager.white,
              enabledBorder: Theme.of(context)
                  .inputDecorationTheme
                  .enabledBorder!
                  .copyWith(borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: Theme.of(context)
                  .inputDecorationTheme
                  .focusedBorder!
                  .copyWith(borderSide: const BorderSide(color: Colors.transparent)),
              errorStyle: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class FileButton extends StatefulWidget {
  const FileButton({
    Key? key,
    required this.text,
    this.onChange,
  }) : super(key: key);

  final String text;
  final Function(File?)? onChange;

  @override
  State<FileButton> createState() => _FileButtonState();
}

class _FileButtonState extends State<FileButton> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSize.s8.w, vertical: AppSize.s8.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s12.r),
      ),
      child: TextButton(
        onPressed: () async {
          var image = await openImagePicker(context);

          if (widget.onChange != null) {
            if (image != null) {
              widget.onChange!(File(image.path));
            } else {
              widget.onChange!(null);
            }
          }
          setState(() {
            _image = image;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.text,
                softWrap: true,
                maxLines: 3,
                style: const TextStyle(color: ColorManager.black, fontSize: AppSize.s14),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_image != null)
                  SizedBox(width: 50, height: 50, child: Image.file(File(_image!.path))),
                const Icon(
                  Icons.photo,
                  color: ColorManager.black,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FullElevatedButton extends StatelessWidget {
  const FullElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s50,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color),
            side: color != null
                ? MaterialStatePropertyAll<BorderSide?>(BorderSide(color: color!))
                : null,
          ),
          onPressed: onPressed,
          child: Text(text)),
    );
  }
}
