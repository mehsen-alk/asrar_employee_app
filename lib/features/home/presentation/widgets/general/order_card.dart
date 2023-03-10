import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../domain/entities/service_order.dart';
import 'accept_button.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final ServiceOrder order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatRoute, arguments: order);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          // horizontal: AppSize.s8.w,
          vertical: AppSize.s8.h,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppSize.s8.w,
          vertical: AppSize.s5.h,
        ),
        decoration: ShapeDecoration(
          shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppSize.s18.r),
          ),
          color: ColorManager.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                color: ColorManager.darkWhite,
                shape: const CircleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.orderNNumber.tr(context),
                      textAlign: TextAlign.center,
                      style: getAlmaraiBoldStyle(
                        fontSize: AppSize.s16.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    SizedBox(height: AppSize.s2.h),
                    Text(
                      order.id.toString(),
                      textAlign: TextAlign.center,
                      style: getAlmaraiBoldStyle(
                        fontSize: AppSize.s16.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppStrings.service.tr(context)}: ${order.service.serviceName}",
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s18.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                  SizedBox(height: AppSize.s10.h),
                  Text(
                    "${AppStrings.status.tr(context)}: ${order.status.tr(context)}",
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s18.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                  SizedBox(height: AppSize.s4.h),
                ],
              ),
            ),
            (order.status == OrderStatus.pending.name)
                ? AcceptButton(
                    order: order,
                    onPressed: () {},
                  )
                : SizedBox(width: AppSize.s50.w),
          ],
        ),
      ),
    );
  }
}
