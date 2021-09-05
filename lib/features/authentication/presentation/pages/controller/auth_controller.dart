import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification_proj/features/authentication/data/datasources/local/auth_local_sharedpref.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/entities/auth_entity.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/add_user_to_db_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/getToken_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_push_notification_proj/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:flutter_push_notification_proj/helpers/constant/constant_method.dart';
import 'package:flutter_push_notification_proj/helpers/routing/app_route.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //-------------------------PROPERTIES-------------
  LoginUseCase? _loginUseCase;
  SignUpUseCase? _signUpUseCase;
  GetTokenUseCase? _tokenUseCase;
  AddUserToFirebaseDbUseCase? _addUserToFirebaseDbUseCase;

  AuthController({
    loginUseCase: LoginUseCase,
    signUpUseCase: SignUpUseCase,
    tokenUseCase: GetTokenUseCase,
    addUserToFirebase: AddUserToFirebaseDbUseCase,
  }) {
    this._loginUseCase = loginUseCase;
    this._signUpUseCase = signUpUseCase;
    this._tokenUseCase = tokenUseCase;
    this._addUserToFirebaseDbUseCase = addUserToFirebase;
  }

  final GlobalKey? _formKey = GlobalKey<FormState>();

  GlobalKey? get formKey => _formKey;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  RxBool _isBusy = false.obs;

  bool get isBusy => _isBusy.value;

  setBusy(bool? isBusy) {
    _isBusy.value = isBusy!;
  }

  //------------------METHODS-----------------------
  Future<void> loginUser() async {
    try {
      setBusy(true);
      UserCredential user = await _loginUseCase!.call(AuthEntity(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      ));

      if (user.user!.uid.isNotEmpty) {
        String? _fbToken = await _tokenUseCase!.call();
        String? _userEmail = user.user!.email;
        await SharedPrefAuth.init();
        SharedPrefAuth.saveEmailOfUser(_userEmail);
        SharedPrefAuth.saveTokenOfUser(_fbToken);
        SharedPrefAuth.saveUserId(user.user!.uid);
        Get.offAllNamed(PageConst.chatList);
      } else {
        ConstantMethod.showErrorSnackBar('Auth Failed, Try again later');
      }
      setBusy(false);
    } catch (e) {
      ConstantMethod.showErrorSnackBar(e.toString());

      setBusy(false);

      throw e;
    }
  }

//Navigate to signUpScreen
  navigateToSignUpScreen() {
    _emailController.clear();
    _passwordController.clear();
    Get.toNamed(PageConst.signup);
  }

  navigateToLoginScreen() {
    _emailController.clear();
    _passwordController.clear();
    Get.back();
  }

  Future<void> signUpUser() async {
    try {
      setBusy(true);
      UserCredential user = await _signUpUseCase!.call(AuthEntity(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      ));
      if (user.user!.uid.isNotEmpty) {
        String? _fbToken = await _tokenUseCase!.call();
        String? _userEmail = user.user!.email;
        debugPrint(_userEmail);
        await SharedPrefAuth.init();
        SharedPrefAuth.saveEmailOfUser(_userEmail);
        SharedPrefAuth.saveTokenOfUser(_fbToken);
        SharedPrefAuth.saveUserId(user.user!.uid);
        await _addUserToFirebaseDbUseCase!
            .call(_userEmail!, _fbToken!, user.user!.uid);
        ConstantMethod.showSuccessSnackBar("Signup-Success");
        Future.delayed(
          Duration(seconds: 3),
        );
        Get.offAllNamed(PageConst.chatList);
      } else {
        ConstantMethod.showErrorSnackBar('Auth Failed, Try again later');
      }
      setBusy(false);
    } catch (e) {
      ConstantMethod.showErrorSnackBar(e.toString());
      setBusy(false);

      throw e;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
