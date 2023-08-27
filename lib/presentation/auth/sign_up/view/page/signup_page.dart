import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/presentation/auth/login/view_model/end_user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../translations/local_keys.g.dart';
import '../../../../component/components.dart';
import '../../../../component/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  Future<void> _submit(context, EndUserViewModel viewModel) async {
    if (kDebugMode) {
      ResponseModel responseModel = await viewModel.register(
          context: context,
          email: "mahmoudsalah@test.com",
          password: "123456789" ,
          confirmPassword: "123456789" ,
          phone: "01006445798" ,
        name: "please don't delete"
      );
      if (responseModel.isSuccess) {
        NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
      }
    } else {
      FocusScope.of(context).unfocus();
      if (!_key.currentState!.validate()) {
        debugPrint("Form Not Valid");
        return;
      }
      _key.currentState!.save();
      ResponseModel responseModel =  await viewModel.register(
          context: context,
          email: _emailController.text,
          password: _passwordController.text ,
          name: _nameController.text ,
        phone: _phoneController.text ,
        confirmPassword: _confirmPasswordController.text
      );
      if (responseModel.isSuccess) {
        NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const VerticalSpace(AppSize.s75),
                  Center(
                    child: CustomAssetsImage(
                      image: AssetsManager.appLogo,
                      //height: 120.h,
                      boxFit: BoxFit.fill,
                      width: deviceWidth * 0.55,
                    ),
                  ),
                  const VerticalSpace(AppSize.s75),

                  //name
                  CustomTextField(
                    controller: _nameController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.person_outline_outlined,
                      size: 30.h,
                    ),
                    // controller: _emailController,
                    hintText:  translate(LocaleKeys.fullName),
                    textInputType: TextInputType.name,
                    maxLine: 1,
                    isValidator: true,
                  ),
                  const VerticalSpace(AppSize.s20),
                  //Email
                  CustomTextField(
                    controller: _emailController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 30.h,
                    ),
                    // controller: _emailController,
                    hintText:  translate(LocaleKeys.email),
                    textInputType: TextInputType.emailAddress,
                    maxLine: 1,
                    isValidator: true,
                  ),

                  const VerticalSpace(AppSize.s20),

                  //Phone
                  CustomTextField(
                    controller: _phoneController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return StringsManager.required;
                      }
                      return null;
                    },
                    isPhoneNumber: true,
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      // size: 30.h,
                    ),

                    // controller: _emailController,
                    hintText:  translate(LocaleKeys.phone),
                    textInputType: TextInputType.emailAddress,
                    maxLine: 1,
                    isValidator: true,
                  ),
                  const VerticalSpace(AppSize.s20),


                  //password
                  CustomTextField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 30.h,
                    ),
                    controller: _passwordController,
                    isValidator: true,
                    hintText:  translate(LocaleKeys.password),
                    maxLine: 1,
                    isPassword: true,
                  ),
                  const VerticalSpace(AppSize.s20),



                  //confirm password
                  CustomTextField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 30.h,
                    ),
                    controller: _confirmPasswordController,
                    isValidator: true,
                    hintText:  translate(LocaleKeys.confirmPassword),
                    maxLine: 1,
                    isPassword: true,
                  ),

                  const VerticalSpace(AppSize.s50),
                  Consumer<EndUserViewModel>(
                    builder: (_ , viewModel , __){
                      return  ! viewModel.isLoading ?
                      CustomButton(
                        radius: 50.r,
                        height: 50.h,
                        width: deviceWidth*0.60,
                        buttonText:  translate(LocaleKeys.create),
                        onTap: () {
                          _submit(context, viewModel) ;
                        },
                      ) :
                          MyProgressIndicator(
                            width: 80.h,
                            height: 80.h,

                          ) ;
                    },
                  ),

                  const VerticalSpace(AppSize.s75),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text:  translate(LocaleKeys.haveAccount),
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TapEffect(
                        onClick: () => NavigationService.push(context, Routes.loginScreen),
                        child: CustomText(
                            text:  translate(LocaleKeys.login),
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.primaryColor,
                              decoration: TextDecoration.underline,
                            )),
                      )
                    ],
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
