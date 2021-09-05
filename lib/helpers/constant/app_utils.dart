import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//App FontSizes define here.
class AppFontSizes {
  static double smallFontSize = 12.sp;
  static double mediumFontSize = 16.sp;
  static double largeFontSize = 20.sp;
  static double xLargeFontSize = 24.sp;
}

class AppFontWeights {
  static FontWeight thinFontWeight = FontWeight.w100;
  static FontWeight smallFontWeight = FontWeight.w300;
  static FontWeight mediumFontWeight = FontWeight.w500;
  static FontWeight boldFontWeight = FontWeight.w600;
}

class AppUtils {
  static double get screenHeight => Get.height;
  static double get screenWidth => Get.width;
  static bool get isOverLayOpen => Get.isOverlaysOpen;
  static bool get isOverLayClose => Get.isOverlaysClosed;

  static String get getCurrentRoute => Get.currentRoute;

  static final kBorderRadius = BorderRadius.circular(10.r);

  //full rounded button used in login view.
  static final kButtonCircularBorderRadius = BorderRadius.circular(20.r);

  //little rounded button for eg using in user profile of psw.
  static final kButtonLittleCircularBorderRadius = BorderRadius.circular(10.r);

  static const kDivider = Divider();

  static const kPaddingHorizontal = EdgeInsets.symmetric(horizontal: 10.0);
  static const kPaddingVertical = EdgeInsets.symmetric(vertical: 10.0);
  static const kPaddingAllSides = EdgeInsets.all(10.0);

  static final onlyTextInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"));
  static final onlyNumberInputFormatter =
      FilteringTextInputFormatter.digitsOnly;
  static final numberAndTextInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r"[a-z0-9]+"));
  static final numberTextAndSpecialCharRegExp =
      FilteringTextInputFormatter.allow(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));

  static final kSizedBoxHeight = SizedBox(
    height: 14.h,
  );

  static final kSizedBoxWidth = SizedBox(
    width: 14.w,
  );

  static SizedBox changeSizedBoxHeight(double height) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox changeSizedBoxWidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Divider changeDivider(
      {double? height, double? endIndent, double? startIndent, Color? color}) {
    return Divider(
      endIndent: endIndent!,
      indent: startIndent!,
      thickness: height!,
      color: color!,
    );
  }
}
