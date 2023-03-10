import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class SwitcherWidget extends StatefulWidget {
  const SwitcherWidget({
    required this.onChange,
    super.key,
    this.executeWhenPressFirst,
    this.executeWhenPressSecond,
    required this.firstButtonLabel,
    required this.secondButtonLabel,
  });
  final String firstButtonLabel;
  final String secondButtonLabel;
  final Function(bool) onChange;
  final Function? executeWhenPressFirst;
  final Function? executeWhenPressSecond;

  @override
  State<SwitcherWidget> createState() => _SwitcherWidgetState();
}

class _SwitcherWidgetState extends State<SwitcherWidget> {
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSize.s40.h,
          width: AppSize.s200.w,
          padding: EdgeInsets.symmetric(horizontal: AppSize.s5.w),
          margin: EdgeInsets.symmetric(
            vertical: AppSize.s10.h,
            horizontal: AppSize.s10.w,
          ),
          decoration: ShapeDecoration(
            color: ColorManager.white,
            shadows: const [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: 3.0,
                offset: Offset(2, 2),
              ),
            ],
            shape: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(
                AppSize.s18.r,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (widget.executeWhenPressFirst != null) {
                    widget.executeWhenPressFirst!();
                  }
                  setState(() {
                    isFirst = true;
                  });
                  widget.onChange(isFirst);
                },
                child: Container(
                  height: AppSize.s35.h,
                  width: AppSize.s95.w,
                  decoration: ShapeDecoration(
                    color: isFirst ? ColorManager.primary : ColorManager.transparent,
                    shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorManager.transparent),
                      borderRadius: BorderRadius.circular(
                        AppSize.s18.r,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.firstButtonLabel,
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s16.sp,
                      color: isFirst ? ColorManager.white : ColorManager.primary,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.executeWhenPressSecond != null) {
                    widget.executeWhenPressSecond!();
                  }
                  setState(() {
                    isFirst = false;
                  });
                  widget.onChange(isFirst);
                },
                child: Container(
                  height: AppSize.s35.h,
                  width: AppSize.s95.w,
                  decoration: ShapeDecoration(
                    color: isFirst ? ColorManager.transparent : ColorManager.primary,
                    shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorManager.transparent),
                      borderRadius: BorderRadius.circular(
                        AppSize.s18.r,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.secondButtonLabel,
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s16.sp,
                      color: isFirst ? ColorManager.primary : ColorManager.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
