import 'package:flutter/material.dart';
import 'package:flutter_push_notification_proj/features/authentication/presentation/pages/controller/auth_controller.dart';
import 'package:flutter_push_notification_proj/helpers/constant/app_utils.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => _authController.isBusy
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _authController.formKey,
                  child: Padding(
                    padding: AppUtils.kPaddingAllSides,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _authController.emailController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            hintText: 'Enter email',
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          controller: _authController.passwordController,
                          autocorrect: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _authController.loginUser();
                          },
                          child: Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            _authController.navigateToSignUpScreen();
                          },
                          child: Text('SignUp'),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
