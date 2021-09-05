import 'package:flutter/material.dart';
import 'package:flutter_push_notification_proj/features/authentication/presentation/pages/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatelessWidget {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => _authController.isBusy
                ? Center(child: CircularProgressIndicator())
                : Column(
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
                          await _authController.signUpUser();
                        },
                        child: Text('Signup'),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     _authController.navigateToLoginScreen();
                      //   },
                      //   child: Text('Login'),
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
