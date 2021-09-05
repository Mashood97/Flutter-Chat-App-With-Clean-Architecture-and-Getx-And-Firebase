import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantMethod {
  static bool isEmailValid(String email) {
    bool _isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return _isValidEmail;
  }

  // static Future<bool> checkInternet() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  // static Future<XFile?> pickImageFromGallery() async {
  //   ImagePicker? _imagePicker = ImagePicker();

  //   final XFile? _imageFile =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);

  //   return _imageFile;
  // }

  static showSuccessSnackBar(
    String? message,
  ) {
    Get.snackbar('Success', message!,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 5));
  }

  static showErrorSnackBar(String? message) {
    Get.snackbar('Failed', message!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 10));
  }

  static showDialog(
      {final onCancel,
      final onConfirm,
      String? cancel,
      String? confirm,
      String? title,
      required Widget content}) {
    Get.defaultDialog(
      title: title!,
      content: content,
      barrierDismissible: false,
      textCancel: cancel,
      textConfirm: confirm,
      //  buttonColor: kBlackColor,
      // cancelTextColor: kBlackColor!,
      // confirmTextColor: kBlackColor,
      onCancel: () {
        onCancel();
        Get.back();
      },
      onConfirm: () {
        onConfirm();
        Get.back();
      },
    );
  }

  // static showDialogWithContent({String? title, VoidCallback? function}) {
  //   Get.dialog(
  //     Container(
  //       height: 50.h,
  //       padding: AppUtils.kPaddingAllSides,
  //       // width: AppUtils.screenWidth ,
  //       child: Card(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             Text(
  //               title!,
  //               style: TextStyle(
  //                 fontSize: AppFontSizes.mediumFontSize,
  //                 fontWeight: AppFontWeights.boldFontWeight,
  //                 color: AppColors.kBlack,
  //                 decoration: TextDecoration.none,
  //               ),
  //             ),
  //             AppUtils.changeSizedBoxHeight(5.h),
  //             AppRoundedButton(
  //               onButtonPressed: function,
  //               appButtonBackgroundColor: AppColors.kGreen,
  //               appButtonFontSize: AppFontSizes.mediumFontSize,
  //               appButtonFontWeight: AppFontWeights.mediumFontWeight,
  //               appButtonTextColor: AppColors.kWhite,
  //               appButtonTitle: 'OK',
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static showDialogwithCustomTitle(
      {final onCancel,
      final title,
      final onConfirm,
      String? cancel,
      String? confirm,
      required Widget content}) {
    Get.defaultDialog(
      title: title,
      content: content,
      textCancel: cancel,
      textConfirm: confirm,
      // buttonColor: kBlackColor,
      // cancelTextColor: kWhiteColor,
      // confirmTextColor: kBlackColor,
      onCancel: () {
        onCancel();

        Get.back();
      },
      onConfirm: () {
        onConfirm();

        Get.back();
      },
    );
  }
}
