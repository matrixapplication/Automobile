import 'package:automobile_project/core/exceptions/error_widget.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/base_response/error_response.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_cities_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brand_model_extension_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_model_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/years_view_model.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/finance_car/view_model/finance_car_view_model.dart';
import 'package:automobile_project/presentation/sell_car_form_page/view_model/sell_change_car_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/navigation/navigation.dart';
import '../../core/resources/resources.dart';
import '../../core/services/network/custom_dio.dart';
import '../../core/services/network/endpoints.dart';
import '../../data/provider/local_auth_provider.dart';
import '../auth/login/view_model/end_user_view_model.dart';
import '../component/app_widgets/my_app_bar.dart';
import '../component/components.dart';
import '../component/custom_button.dart';

class FinanceCarPage extends StatefulWidget {
  const FinanceCarPage({Key? key}) : super(key: key);

  @override
  State<FinanceCarPage> createState() => _SelCarFormPageState();
}

class _SelCarFormPageState extends State<FinanceCarPage> {
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedClass;
  String? _selectedYear;
  String? _selectedDistance;
  String? _selectedCity;

  bool selectBrand = false;
  bool selectModel = false;
  bool selectClass = false;
  bool selectDistance = false;
  bool selectCity = false;
  bool selectYear = false;
  bool terms = false;

  Map<String, dynamic> formData = {
    "brand_id": null,
    "car_model_id": null,
    "year": null,
    "gross_salary": null,
    "city_id": null,
    "name": null,
    "phone": null,
  };
  final _key = GlobalKey<FormState>();
  final _keyStep1 = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool isSwitched1 = false;
  int currentStep = 0;
  bool isCompleted = false;

  BasicModel? brand;

  BasicModel? brandModel;

  BasicModel? brandModelEx;

  BasicModel? carYearModel;


  Future<void> _submit(
    context,
  ) async
  {
    formData = {
      "brand_id": _selectedBrand,
      "car_model_id": _selectedModel,
      "year": _selectedYear,
      "gross_salary": _priceController.text,
      "city_id": _selectedCity,
      "name": _nameController.text,
      "phone": _phoneController.text,
    };

    final financeCarProvider =
        Provider.of<FinanceCarViewModel>(context, listen: false);
    // if (kDebugMode) {
    //   ResponseModel responseModel = await financeCarProvider.financeCar(
    //       context: context, formData: formData);
    //   print('responseModel.data ${responseModel.message}');
    //   if (responseModel.isSuccess) {
    //     showCustomSnackBar(
    //         isError: false,
    //         message: responseModel.message ?? "",
    //         context: context);
    //     //NavigationService.pushReplacement(context, Routes.homeScreen)
    //     NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
    //   } else {
    //     showCustomSnackBar(
    //         message: "${responseModel.message}", context: context);
    //   }
    // } else {
    print("formDsfddsfffffffata ${formData}");
      FocusScope.of(context).unfocus();
      if (_keyStep1.currentState!.validate()) {
          // _key.currentState!.save();
          // if (isSwitched1) {
          //   setState(() {
          //     terms =false ;
          //   });
            ResponseModel responseModel = await financeCarProvider.financeCar(
                context: context, formData: formData);
            if (responseModel.isSuccess) {
             NavigationService.goBack(context) ;
             //  final userProvider = Provider.of<LocalAuthProvider>(context , listen: false);
              showCustomSnackBar(
                  message: "Successfully",
                  context: context);
             //  if(await userProvider.isLogin()){
             //    NavigationService.pushReplacement(
             //        context, Routes.bottomNavigationBar);
             //  } else {
             //    // _autoRegister(context, Provider.of<EndUserViewModel>(context , listen: false));
             //  }
            } else {
              showCustomSnackBar(
                  message: "${responseModel.message}", context: context);
            }
          } else {
            setState(() {
              terms =true ;
            });

        // }
      // }
    }
    financeCarProvider.offLoading();
  }

 String? phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhone();
  }
  getPhone()async{
    phone = await Provider.of<FinanceCarViewModel>(context, listen: false).getContactUs( context);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: MyAppbar(
            title: translate(LocaleKeys.financeCar),
            titleColor: ColorManager.white,
            backgroundColor: ColorManager.primaryColor,
            centerTitle: true,
            leading: TapEffect(
                onClick: () {
                  NavigationService.goBack(context);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.white,
                  textDirection: shared!.getString("lang") == "ar"
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                )),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(50),
              Consumer<CarBrandsViewModel>(builder: (_, data, __) {
                return DropdownSearch<BasicModel>(
                  asyncItems: (filter) async =>
                  data.getBrandsResponse!.data!,
                  itemAsString: (BasicModel u) => u.name!,
                  onChanged: (BasicModel? data) {
                    setState(() {
                      selectBrand = false;
                      _selectedBrand = data!.id!.toString();
                      brandModel = null;
                      _selectedModel = null;
                      _selectedClass = null;
                      Provider.of<CarBrandsModelViewModel>(context,
                          listen: false)
                          .getBrandsModels(
                          context: context,
                          brandId: int.parse(_selectedBrand!));
                    });
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: translate(LocaleKeys.selectBrand),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.primaryColor),
                        fillColor: ColorManager.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2))),
                  ),
                  dropdownBuilder: (_, value) {
                    return _selectedBrand != null
                        ? Row(
                      children: [
                        CustomShimmerImage(
                          image: value?.image ?? '',
                          height: 20,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: value?.name ?? '',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge,
                        )
                      ],
                    )
                        : Row(
                      children: [
                        const CustomAssetsImage(
                          image: AssetsManager.brandIcon,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: translate(LocaleKeys.selectBrand),
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        )
                      ],
                    );
                  },
                  popupProps: PopupProps.menu(
                      itemBuilder: (_, value, state) {
                        return Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: value.name ?? '',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge,
                              ),
                              CustomShimmerImage(
                                image: value.image ?? '',
                                height: 40.h,
                                width: 40.h,
                                boxFit: BoxFit.contain,
                              ),
                            ],
                          ),
                        );
                      },
                      fit: FlexFit.loose),
                  dropdownButtonProps: DropdownButtonProps(
                      icon: !data.isLoading
                          ? const Icon(Icons.keyboard_arrow_down)
                          : const MyProgressIndicator(
                        width: 30,
                        height: 30,
                        size: 30,
                      )),
                );
              }),
              selectBrand
                  ? CustomText(
                text: translate(LocaleKeys.required),
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: ColorManager.primaryColor),
              )
                  : const SizedBox(),
              const VerticalSpace(20),
              Consumer<CarBrandsModelViewModel>(builder: (_, data, __) {
                return IgnorePointer(
                  ignoring:
                  data.getBrandModelsResponse != null ? false : true,
                  child: DropdownSearch<BasicModel>(
                    asyncItems: (filter) async =>
                    data.getBrandModelsResponse!.data!,
                    itemAsString: (BasicModel u) => u.name!,
                    selectedItem: brandModel,
                    onChanged: (BasicModel? data) {
                      setState(() {
                        _selectedModel = data!.id.toString();
                        brandModel = data;
                        _selectedClass = null;
                        brandModelEx = null;
                        selectModel = false;
                        Provider.of<CarBrandsModelExtensionViewModel>(
                            context,
                            listen: false)
                            .getBrandsModels(
                            context: context,
                            id: int.parse(_selectedModel.toString()));
                        Provider.of<YearsViewModel>(context, listen: false).getYears(context: context);

                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: translate(LocaleKeys.selectModel),
                          enabled: brandModel != null ? true : false,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: ColorManager.primaryColor),
                          fillColor: ColorManager.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2))),
                    ),
                    dropdownBuilder: (_, value) {
                      return brandModel != null
                          ? Row(
                        children: [
                          CustomText(
                            text: value?.name ?? '',
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge,
                          )
                        ],
                      )
                          : Row(
                        children: [
                          const CustomAssetsImage(
                            image: AssetsManager.carModel,
                            height: 18,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            text: translate(LocaleKeys.selectModel),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          )
                        ],
                      );
                    },
                    popupProps: PopupProps.menu(
                        itemBuilder: (_, value, state) {
                          return Padding(
                            padding: EdgeInsets.all(16.h),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: value.name ?? '',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge,
                                ),
                              ],
                            ),
                          );
                        },
                        fit: FlexFit.loose),
                    dropdownButtonProps: DropdownButtonProps(
                        icon: !data.isLoading
                            ? const Icon(Icons.keyboard_arrow_down)
                            : const MyProgressIndicator(
                          width: 30,
                          height: 30,
                          size: 30,
                        )),
                  ),
                );
              }),
              selectModel
                  ? CustomText(
                text: translate(LocaleKeys.required),
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: ColorManager.primaryColor),
              )
                  : const SizedBox(),

              const VerticalSpace(20),
              Consumer<YearsViewModel>(
                builder: (_, data, __) {
                  return DropdownSearch<int>(
                    asyncItems: (filter) async =>
                    data.getYearsResponse!.data!,
                    itemAsString: (int u) => u.toString(),
                    onChanged: (int? data) {
                      setState(() {
                        _selectedYear = data.toString();
                        selectYear = false;
                      });
                      Provider.of<GetCitiesViewModel>(context, listen: false).getCities(context: context);
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: translate(LocaleKeys.carYear),
                          enabled: data.getYearsResponse != null
                              ? true
                              : false,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: ColorManager.primaryColor),
                          fillColor: ColorManager.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2))),
                    ),
                    dropdownBuilder: (_, value) {
                      return _selectedYear != null
                          ? Row(
                        children: [
                          CustomText(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge,
                            text: value.toString(),
                          )
                        ],
                      )
                          : Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            text: translate(LocaleKeys.carYear),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          )
                        ],
                      );
                    },
                    popupProps: PopupProps.menu(
                        itemBuilder: (_, value, state) {
                          return Padding(
                            padding: EdgeInsets.all(16.h),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: value.toString(),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge,
                                ),
                              ],
                            ),
                          );
                        },
                        fit: FlexFit.loose),
                    dropdownButtonProps: DropdownButtonProps(
                        icon: !data.isLoading
                            ? const Icon(Icons.keyboard_arrow_down)
                            : const MyProgressIndicator(
                          width: 30,
                          height: 30,
                          size: 30,
                        )),
                  );
                },
              ),
              selectYear
                  ? CustomText(
                text: translate(LocaleKeys.required),
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: ColorManager.primaryColor),
              )
                  : const SizedBox(),
              const VerticalSpace(20),
              Consumer<GetCitiesViewModel>(builder: (_, data, __) {
                return DropdownSearch<BasicModel>(
                  asyncItems: (filter) async =>
                  data.getCitiesRespose!.data!,
                  itemAsString: (BasicModel u) => u.name!,
                  onChanged: (BasicModel? data) {
                    setState(() {
                      _selectedCity = data!.id.toString();
                      formData['city_id'] = _selectedCity;
                    });
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: translate(LocaleKeys.selectCity),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.primaryColor),
                        fillColor: ColorManager.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                                color: ColorManager.greyCanvasColor,
                                width: 2))),
                  ),
                  dropdownBuilder: (_, value) {
                    return _selectedCity != null
                        ? Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: value?.name ?? '',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge,
                        )
                      ],
                    )
                        : Row(
                      children: [
                        CustomText(
                          text: translate(LocaleKeys.selectCity),
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        )
                      ],
                    );
                  },
                  popupProps: PopupProps.menu(
                      itemBuilder: (_, value, state) {
                        return Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: value.name ?? '',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge,
                              ),
                            ],
                          ),
                        );
                      },
                      fit: FlexFit.loose),
                  dropdownButtonProps: DropdownButtonProps(
                    icon: !data.isLoading
                        ? const Icon(Icons.keyboard_arrow_down)
                        : const MyProgressIndicator(
                      width: 30,
                      height: 30,
                      size: 30,
                    ),
                  ),
                );
              }),
              const VerticalSpace(20),
              Form(
                key: _keyStep1,
                child:
                    Column(
                      children: [
                        CustomTextField(
                          height: 70.h,
                          controller: _nameController,
                          textInputType: TextInputType.name,
                          onChange: (String? value) {
                            formData['name'] = value;
                          },
                          prefixIcon: const Icon(
                            Icons.person_outline_outlined,
                            color: ColorManager.primaryColor,
                          ),
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.required;
                            }
                            return null;
                          },
                          hintText: translate(LocaleKeys.fullName),
                          borderColor: ColorManager.greyColorD6D6D6,
                          borderRadius: 15.r,
                        ),
                        CustomTextField(
                          height: 70.h,
                          controller: _phoneController,
                          textInputType: TextInputType.number,
                          onChange: (String? value) {
                            formData['phone'] = value;
                          },
                          hintText: translate(LocaleKeys.phone),
                          isPhoneNumber: true,
                          isValidator: true,
                          prefixIcon: const Icon(
                            Icons.phone_android,
                            color: ColorManager.primaryColor,
                          ),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return StringsManager.required;
                            } else if (value.length < 11) {
                              return translate(LocaleKeys.phoneErrorMessage);
                            }
                            return null;
                          },
                          borderColor: ColorManager.greyColorD6D6D6,
                          borderRadius: 15.r,
                        ),
                        CustomTextField(
                          height: 70.h,
                          controller: _priceController,
                          textInputType: TextInputType.number,
                          onChange: (String? value) {
                            formData['gross_salary'] = value;
                          },
                          prefixIcon: const Icon(
                            Icons.price_change_outlined,
                            color: ColorManager.primaryColor,
                          ),
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.required;
                            }
                            return null;
                          },
                          hintText: translate(LocaleKeys.grossSalary),
                          borderColor: ColorManager.greyColorD6D6D6,
                          borderRadius: 15.r,
                        ),
                      ],
                    )

              ),
              selectCity
                  ? CustomText(
                text: translate(LocaleKeys.required),
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: ColorManager.primaryColor),
              )
                  : const SizedBox(),

              const VerticalSpace(40),

              const VerticalSpace(40),

              CustomButton(
                  buttonText: translate(LocaleKeys.next),
                  onTap: () {
                    if (_selectedBrand != null &&
                        _selectedModel != null &&
                        _selectedYear != null &&
                        _selectedCity != null) {
                      print("formData ${formData}");
                       _submit(context);

                    } else {
                      // setState(() {
                      //   if (_selectedBrand == null) {
                      //     selectBrand = true;
                      //   }
                      //   if (_selectedModel == null) {
                      //     selectModel = true;
                      //   }
                      //
                      //   if (_selectedClass == null) {
                      //     selectClass = true;
                      //   }
                      //
                      //   if (_selectedYear == null) {
                      //     selectYear = true;
                      //   }
                      //
                      //   if (_selectedDistance == null) {
                      //     selectDistance = true;
                      //   }
                      // });
                      showCustomSnackBar(
                          message: "Please complete the form first ",
                          context: context);
                    }
                  }),
              const VerticalSpace(20),
              if(phone != null)
              Row(
                children: [
                  Expanded(
                    child: TapEffect(
                        onClick: () async{
                          final phoneUrl = "tel:${phone!}"; // Use your desired phone number
                          if (await canLaunch(phoneUrl)) {
                          await launch(phoneUrl);
                          } else {
                          throw 'Could not launch $phoneUrl';
                          }

                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(12.r),
                            color: ColorManager.greyColorCBCBCB
                                .withOpacity(0.6),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.call,
                                  color: ColorManager.primaryColor),
                              HorizontalSpace(10.w),
                              CustomText(
                                text: translate(LocaleKeys.call),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    fontWeight:
                                    FontWeightManager
                                        .semiBold,
                                    color: ColorManager
                                        .primaryColor),
                              )
                            ],
                          ),
                        )),
                  ),
                  HorizontalSpace(10.w),
                  Expanded(
                    child: TapEffect(
                        onClick: () async {
                          final whatsappUrl = "https://wa.me/${phone!}"; // Use the WhatsApp API with a phone number
                          if (await canLaunch(whatsappUrl)) {
                          await launch(whatsappUrl);
                          } else {
                          throw 'Could not launch $whatsappUrl';
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(12.r),
                            color: ColorManager.primaryColor,
                          ),
                          padding:
                          EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const CustomSvgImage(
                                  image: AssetsManager.whatsAppIcon,
                                  color: Colors.white),
                              HorizontalSpace(10.w),
                              CustomText(
                                text: translate(LocaleKeys.whatsApp),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    fontWeight:
                                    FontWeightManager
                                        .semiBold,
                                    color: ColorManager.white),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     IconButton(
              //       iconSize: 50,
              //       color: Colors.green,
              //       icon: const FaIcon(FontAwesomeIcons.whatsapp),
              //       onPressed: () async {
              //         final whatsappUrl = "https://wa.me/${phone!}"; // Use the WhatsApp API with a phone number
              //         if (await canLaunch(whatsappUrl)) {
              //         await launch(whatsappUrl);
              //         } else {
              //         throw 'Could not launch $whatsappUrl';
              //         }
              //       },
              //     ),
              //     IconButton(
              //       iconSize: 40,
              //       color: Colors.blue,
              //       icon: FaIcon(FontAwesomeIcons.phone),
              //       onPressed: ()async{
              //         final phoneUrl = "tel:${phone!}"; // Use your desired phone number
              //         if (await canLaunch(phoneUrl)) {
              //         await launch(phoneUrl);
              //         } else {
              //         throw 'Could not launch $phoneUrl';
              //         }
              //         // Add your functionality here
              //       },
              //     ),
              //
              //   ],
              // )

            ]),
      )
    );
  }
}
