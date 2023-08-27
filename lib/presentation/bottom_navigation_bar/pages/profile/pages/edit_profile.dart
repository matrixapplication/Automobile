import 'dart:io';

import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/auth/login/view_model/end_user_view_model.dart';
import 'package:automobile_project/presentation/auth/show_room_login/view_model/show_room_login_view_model.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:easy_localization/easy_localization.dart' as EasyLocale;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../translations/local_keys.g.dart';
import '../../../../component/app_widgets/my_app_bar.dart';
import '../../../../component/components.dart';
import '../../../../component/custom_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _showRoomNameController = TextEditingController();
  final TextEditingController _whatsAppController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? mainImage;
  final ImagePicker _picker = ImagePicker();


  @override
  void dispose() {

    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _whatsAppController.dispose() ;
    _showRoomNameController.dispose() ;
    super.dispose();
  }

  Future<void> _submit(context, EndUserViewModel viewModel) async {
    if (kDebugMode) {
      ResponseModel responseModel = await viewModel.editProfileEndUser(
          context: context,
          email: "mahmoudsalah@test.com",
          password: "12345678" ,
          confirmPassword: "12345678" ,
          phone: "01006449771" ,
          name: "please don't delete"
      );
      if (responseModel.isSuccess) {
        //NavigationService.pushReplacement(context, Routes.homeScreen);


        await viewModel.getEndUserData(context: context, token: shared!.getString("token")!).
        then((value) =>  NavigationService.pushReplacement(context, Routes.bottomNavigationBar));


      }
    } else {
      FocusScope.of(context).unfocus();
      if (!_key.currentState!.validate()) {
        debugPrint("Form Not Valid");
        return;
      }
      _key.currentState!.save();
      ResponseModel responseModel =await viewModel.editProfileEndUser(
          context: context,
          email: _emailController.text,
          password: _passwordController.text ,
          name: _nameController.text ,
          phone: _phoneController.text ,
          confirmPassword: _passwordController.text
      );

      if(responseModel.isSuccess){

        await viewModel.getEndUserData(context: context, token: shared!.getString("token")!).then((value)
        => NavigationService.pushReplacement(context, Routes.bottomNavigationBar)) ;

      }
    }
  }
  Future<void> _showRoomSubmit(context, ShowRoomLoginViewModel viewModel) async {
    if (kDebugMode) {
      ResponseModel responseModel = await viewModel.editProfileShowRoom(
          context: context,
          code: "1400",
          password: "123456789" ,
          confirmPassword: "123456789" ,
          phone: "123456789" ,
          whatsApp: "123456789",
          name: "test1" ,
        showRoomName: "showroom test" ,
        coverImage: mainImage?.path
      );
      if (responseModel.isSuccess) {
        //NavigationService.pushReplacement(context, Routes.homeScreen);


        await viewModel.getShowRoomData(context: context).
        then((value) =>  NavigationService.pushReplacement(context, Routes.bottomNavigationBar));


      }
    } else {
      FocusScope.of(context).unfocus();
      if (!_key.currentState!.validate()) {
        debugPrint("Form Not Valid");
        return;
      }

      _key.currentState!.save();
      ResponseModel responseModel =await viewModel.editProfileShowRoom(
          context: context,
          code: _emailController.text,
          whatsApp: _whatsAppController.text,
          showRoomName: _showRoomNameController.text,
          password: _passwordController.text ,
          name: _nameController.text ,
          phone: _phoneController.text ,
          confirmPassword: _passwordController.text ,
          coverImage: mainImage?.path
      );

      if(responseModel.isSuccess){

        await viewModel.getShowRoomData(context: context,).then((value)
        => NavigationService.pushReplacement(context, Routes.bottomNavigationBar)) ;

      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds:0 ) , ()async{
      final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;

      if(userProvider.user?.role == "showroom" || userProvider.user?.role == "agency"){
        _nameController.text = userProvider.user!.ownerName! ;
        _showRoomNameController.text = userProvider.user!.showroomName! ;
        _emailController.text = userProvider.user!.code! ;
        _phoneController.text = userProvider.user!.phone! ;
        _whatsAppController.text = userProvider.user!.whatsapp! ;

      }else {
        _nameController.text = userProvider.endUser!.name! ;
        _emailController.text = userProvider.endUser!.email! ;
        _phoneController.text = userProvider.endUser!.phone! ;
    }}) ;
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.editProfile),
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,
        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            //context.locale.languageCode == "en" ?
            child:  EasyLocale.EasyLocalization.of(context)!.locale.languageCode == "en" ?
              Icon(

              Icons.arrow_back_ios_new_outlined ,
              color: ColorManager.white,
            ) :  Icon(

              Icons.arrow_forward_ios ,
              color: ColorManager.white,
            )),
      )),
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

                  shared!.getString("role") == "showroom" || shared!.getString("role") == "agency" ?
                  TapEffect(
                    onClick: () async {
                      final XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          mainImage = File(pickedFile.path);
                          print("courseImage =>${pickedFile.path.split("/").last}");
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: deviceHeight * 0.15,
                      decoration: BoxDecoration(
                          color: ColorManager.greyColorF4F4F4,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: mainImage != null
                          ? Image.file(
                          File(
                            mainImage!.path ?? "",
                          ),
                          fit: BoxFit.cover)
                          : userProvider.user?.coverImage != null ?  
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.black.withOpacity(0.1) ,
                                      blurRadius: 58 ,
                                      offset: const Offset(0, 0) ,
                                      
                                    )
                                  ]
                                ),
                                child: CustomShimmerImage(
                                  image: userProvider.user!.coverImage! , width: double.infinity,) ,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child:Container(
                                  padding: EdgeInsets.all(8.h),
                                  decoration: BoxDecoration(
                                    color: ColorManager.primaryColor.withOpacity(0.3) ,
                                    borderRadius: BorderRadius.circular(8.h) ,

                                  ),
                                  child: CustomText(text: "Change Cover Image",
                                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorManager.white ,
                                      fontWeight: FontWeight.bold
                                    ),
                                )),
                              )
                            ],
                          )
                          : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image,
                                color: ColorManager.blueColor, size: 100.h),
                            CustomText(
                                text: "Add Cover Image Here",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                    fontWeight:
                                    FontWeightManager.semiBold,
                                    color: ColorManager.blueColor)),
                          ]),
                    ),
                  ) : const SizedBox(),
                  shared!.getString("role") == "showroom" || shared!.getString("role") == "agency" ?
                      SizedBox(
                        height: 10.h,
                      ) : const SizedBox() ,
                  //name
                  CustomTextField(
                    controller: _nameController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return translate(LocaleKeys.required);
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.person_outline_outlined,
                      size: 30.h,
                    ),
                    // controller: _emailController,
                    hintText: translate(LocaleKeys.fullName),
                    textInputType: TextInputType.name,
                    maxLine: 1,
                    isValidator: true,
                  ),
                  userProvider.user?.role == "showroom" || userProvider.user?.role == "agency" ?
                  const VerticalSpace(AppSize.s20) : const SizedBox(),
                  userProvider.user?.role == "showroom" || userProvider.user?.role == "agency"  ?
                  CustomTextField(
                    controller: _showRoomNameController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return translate(LocaleKeys.required);
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.groups,
                      size: 30.h,
                    ),
                    // controller: _emailController,
                    hintText: translate(LocaleKeys.showRoomName),
                    textInputType: TextInputType.name,
                    maxLine: 1,
                    isValidator: true,
                  ) :
                  const SizedBox(),
                  const VerticalSpace(AppSize.s20),
                  //Email
                  CustomTextField(
                    controller: _emailController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return translate(LocaleKeys.required);
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      userProvider.user?.role == "showroom" || userProvider.user?.role == "agency" ?
                      Icons.numbers : Icons.email_outlined,
                      size: 30.h,
                    ),
                    // controller: _emailController,
                    hintText: translate(LocaleKeys.email),
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
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      // size: 30.h,
                    ),

                    // controller: _emailController,
                    hintText: translate(LocaleKeys.phone),
                    textInputType: TextInputType.emailAddress,
                    maxLine: 1,
                    isValidator: true,
                  ),
                  userProvider.user?.role == "showroom" || userProvider.user?.role == "agency" ?
                  const VerticalSpace(AppSize.s20) : const SizedBox(),
                  userProvider.user?.role == "showroom" || userProvider.user?.role == "agency" ?
                  CustomTextField(
                    controller: _whatsAppController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return StringsManager.required;
                      }
                      return null;
                    },
                    // prefix: SizedBox(
                    //   height: 20.h,
                    //   width: 20.h,
                    //   child: CustomSvgImage(image: AssetsManager.whatsAppIcon , height: 20.h,width: 20.h , boxFit: BoxFit.fill, ),
                    // ),
                    prefixIcon: SizedBox(
                      height: 17.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSvgImage(image: AssetsManager.whatsAppIcon , height: 20.h,width: 20.h , boxFit: BoxFit.fill,color: ColorManager.black, )
                        ],
                      ),
                    ),

                    // controller: _emailController,
                    hintText: translate(LocaleKeys.whatsApp),
                    textInputType: TextInputType.emailAddress,
                    maxLine: 1,
                    isValidator: true,
                  ) :
                  const SizedBox(),
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
                  shared!.getString("role") == "showroom" ||
                      shared!.getString("role") == "agency"  ?
                  Consumer<ShowRoomLoginViewModel>(
                    builder: (_, viewModel , __){
                      return !viewModel.isLoading ?
                      CustomButton(
                        radius: 50.r,
                        height: 50.h,
                        width: deviceWidth * 0.60,
                        buttonText: translate(LocaleKeys.save),
                        onTap: () async {

                            _showRoomSubmit(context, viewModel) ;
                          // NavigationService.pushReplacementAll(context, Routes.bottomNavigationBar , );
                        },
                      ) :
                          MyProgressIndicator(
                            width: 80.h ,
                              height: 80.h,
                          ) ;
                    },
                  ) :
                  Consumer<EndUserViewModel>(
                    builder: (_, viewModel , __){
                      return !viewModel.isLoading ?
                      CustomButton(
                        radius: 50.r,
                        height: 50.h,
                        width: deviceWidth * 0.60,
                        buttonText: translate(LocaleKeys.save),
                        onTap: () async {

                          _submit(context, viewModel) ;
                          // NavigationService.pushReplacementAll(context, Routes.bottomNavigationBar , );
                        },
                      ) :
                      MyProgressIndicator(
                        width: 80.h ,
                        height: 80.h,
                      ) ;
                    },
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
