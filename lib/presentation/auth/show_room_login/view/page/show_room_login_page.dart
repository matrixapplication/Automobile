import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../bottom_navigation_bar/pages/home/pages/home_page.dart';
import '../../../../component/components.dart';
import '../../../../component/custom_button.dart';
import '../../view_model/show_room_login_view_model.dart';


class ShowRoomLoginPage extends StatefulWidget {
  const ShowRoomLoginPage({Key? key}) : super(key: key);

  @override
  State<ShowRoomLoginPage> createState() => _ShowRoomLoginPageState();
}

class _ShowRoomLoginPageState extends State<ShowRoomLoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submit(context, ShowRoomLoginViewModel viewModel) async {
  final userProvider = Provider.of<LocalAuthProvider>(context ,listen: false) ;
    if (kDebugMode) {
      ResponseModel responseModel = await viewModel.login(
          context: context, code: "1438", password: "123456789");
      if (responseModel.isSuccess) {
        //NavigationService.pushReplacement(context, Routes.homeScreen);
        await userProvider.isLogin()  ;
        NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
      }
    } else {
      FocusScope.of(context).unfocus();
      if (!_key.currentState!.validate()) {
        debugPrint("Form Not Valid");
        return;
      }
      _key.currentState!.save();
      ResponseModel responseModel = await viewModel.login(
          context: context,
          code: _emailController.text,
          password: _passwordController.text);
      if (responseModel.isSuccess) {
        await userProvider.isLogin()  ;
        NavigationService.pushReplacementAll(context, Routes.bottomNavigationBar) ;
        /*       showCustomSnackBar(
          message: responseModel.message.toString(),
          context: context,
          isError: false,
        );*/

        /*     Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );*/
        // NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            child: SizedBox(

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
                    CustomText(
                        text: translate(LocaleKeys.welcome),
                        textStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                            height: 0.8,
                            color: ColorManager.lightBlack,
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s28.sp)),
                    CustomText(
                        text: translate(LocaleKeys.pleaseLogin),
                        textStyle:
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: ColorManager.lightBlack,
                          fontWeight: FontWeightManager.regular,
                        )),
                    const VerticalSpace(AppSize.s50),

                    //Email
                    CustomTextField(
                      controller: _emailController,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return translate(LocaleKeys.required);
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.numbers_outlined,
                        // size: 30.h,
                      ),

                      // controller: _emailController,
                      hintText: translate(LocaleKeys.code),
                      textInputType: TextInputType.emailAddress,
                      maxLine: 1,
                      isValidator: true,
                    ),
                    const VerticalSpace(AppSize.s20),
                    //password
                    CustomTextField(
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return translate(LocaleKeys.required);
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 30.h,
                      ),
                      controller: _passwordController,
                      isValidator: true,
                      hintText: translate(LocaleKeys.password),
                      maxLine: 1,
                      isPassword: true,
                    ),
                    const VerticalSpace(AppSize.s50),
                    Center(
                      child: Consumer<ShowRoomLoginViewModel>(
                        builder: (context, viewModel, child) =>
                        !viewModel.isLoading ?
                        CustomButton(
                          loading: viewModel.isLoading,
                          radius: 50.r,
                          height: 50.h,
                          width: deviceWidth * 0.60,
                          buttonText: translate(LocaleKeys.login),
                          onTap: () => _submit(context, viewModel),
                        ) : MyProgressIndicator(
                          height: 80.h,
                          width: 80.h,

                        ),
                      ),
                    ),
                    // const VerticalSpace(AppSize.s50),
                    // Center(
                    //   child: CustomText(
                    //     text: translate(LocaleKeys.forgetPassword),
                    //     textStyle: Theme.of(context)
                    //         .textTheme
                    //         .bodyLarge!
                    //         .copyWith(color: ColorManager.greyColor919191),
                    //   ),
                    // ),

                    // const VerticalSpace(AppSize.s30),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     CustomText(
                    //       text: translate(LocaleKeys.doNotHaveAccount),
                    //       textStyle: Theme.of(context).textTheme.bodyLarge,
                    //     ),
                    //     TapEffect(
                    //       onClick: () {
                    //         NavigationService.push(context, Routes.signupScreen);
                    //       },
                    //       child: CustomText(
                    //           text: translate(LocaleKeys.createNewNow),
                    //           textStyle:
                    //           Theme.of(context).textTheme.bodyLarge!.copyWith(
                    //             fontWeight: FontWeightManager.bold,
                    //             color: ColorManager.primaryColor,
                    //             decoration: TextDecoration.underline,
                    //           )),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

