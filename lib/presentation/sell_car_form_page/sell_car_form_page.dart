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
import 'package:automobile_project/presentation/sell_car_form_page/view_model/sell_change_car_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/navigation/navigation.dart';
import '../../core/resources/resources.dart';
import '../component/app_widgets/my_app_bar.dart';
import '../component/components.dart';
import '../component/custom_button.dart';

class SelCarFormPage extends StatefulWidget {
  const SelCarFormPage({Key? key}) : super(key: key);

  @override
  State<SelCarFormPage> createState() => _SelCarFormPageState();
}

class _SelCarFormPageState extends State<SelCarFormPage> {
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
  List<String> distanceList = [
    '30,000',
    '40,000',
    "50,000",
    "60,000",
    "70,000",
    "80,000",
    '90,000',
    '100,000'
  ];

  Map<String, dynamic> formData = {
    "brand_id": null,
    "car_model_id": null,
    "car_model_extension_id": null,
    "year": null,
    "mileage": null,
    "city_id": null,
    "name": null,
    "phone": null,
  };
  final _key = GlobalKey<FormState>();
  final _keyStep1 = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  bool isSwitched1 = false;
  int currentStep = 0;
  bool isCompleted = false;

  BasicModel? brand;

  BasicModel? brandModel;

  BasicModel? brandModelEx;

  BasicModel? carYearModel;

  List<Step> getSteps() => [
        Step(
          //for check true icon

          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: CustomText(
              text: translate(LocaleKeys.carDetails),
              textStyle: Theme.of(context).textTheme.titleSmall),
          content: Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
              //height: 300.h,
              //  color: Colors.grey.withOpacity(0.4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
/*
                CustomText(
                    text: "Car brand",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeightManager.semiBold)),*/
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
                    Consumer<CarBrandsModelExtensionViewModel>(
                        builder: (_, data, __) {
                      return IgnorePointer(
                        ignoring:
                            data.getCarBrandsModelExtensionResponse != null
                                ? false
                                : true,
                        child: DropdownSearch<BasicModel>(
                          asyncItems: (filter) async =>
                              data.getCarBrandsModelExtensionResponse!.data!,
                          itemAsString: (BasicModel u) => u.name!,
                          selectedItem: brandModelEx,
                          onChanged: (BasicModel? data) {
                            setState(() {
                              brandModelEx = data;
                              _selectedClass = data!.id.toString();
                              selectClass = false;
                            });
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                labelText:
                                    translate(LocaleKeys.carModelExtention),
                                enabled:
                                    data.getCarBrandsModelExtensionResponse != null
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
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: const BorderSide(color: ColorManager.greyCanvasColor, width: 2))),
                          ),
                          dropdownBuilder: (_, value) {
                            return brandModelEx != null
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
                                        image: AssetsManager.carModelExIcon,
                                        height: 18,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      CustomText(
                                        text: translate(
                                            LocaleKeys.carModelExtention),
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
                    selectClass
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
                      child: CustomTextField(
                        height: 70.h,
                        controller: _mileageController,
                        textInputType: TextInputType.number,
                        onChange: (String? value) {
                          formData['mileage'] = value;
                        },
                        prefixIcon: const Icon(
                          Icons.speed_outlined,
                          color: ColorManager.primaryColor,
                        ),
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.required;
                          }
                          return null;
                        },
                        hintText: translate(LocaleKeys.mileage),
                        borderColor: ColorManager.greyColorD6D6D6,
                        borderRadius: 15.r,
                      ),
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
                    CustomButton(
                        buttonText: translate(LocaleKeys.next),
                        onTap: () {
                          if (_selectedBrand != null &&
                              _selectedModel != null &&
                              _selectedClass != null &&
                              _selectedYear != null &&
                              _selectedCity != null) {
                            setState(() {
                              currentStep = 1;
                            });
                          } else {
                            setState(() {
                              if (_selectedBrand == null) {
                                selectBrand = true;
                              }
                              if (_selectedModel == null) {
                                selectModel = true;
                              }

                              if (_selectedClass == null) {
                                selectClass = true;
                              }

                              if (_selectedYear == null) {
                                selectYear = true;
                              }

                              if (_selectedDistance == null) {
                                selectDistance = true;
                              }
                            });
                            showCustomSnackBar(
                                message: "Please complete the form first ",
                                context: context);
                          }
                        }),
                  ]),
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: CustomText(
              text: translate(LocaleKeys.personalInfo),
              textStyle: Theme.of(context).textTheme.titleSmall),
          content: Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
              //height: 300.h,
              //  color: Colors.grey.withOpacity(0.4),
              child: Form(
                key: _key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const VerticalSpace(AppSize.s20),
                      //Phone
                      CustomTextField(
                        controller: _phoneController,
                        isPhoneNumber: true,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return StringsManager.required;
                          } else if (value.length < 11) {
                            return translate(LocaleKeys.phoneErrorMessage);
                          }
                          return null;
                        },
                        prefixIcon: const Icon(
                          Icons.phone_android,
                          // size: 30.h,
                        ),
                        hintText: translate(LocaleKeys.phone),
                        textInputType: TextInputType.number,
                        maxLine: 1,
                        isValidator: true,
                      ),
                      const VerticalSpace(AppSize.s20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (terms == false) {
                                  terms = true;
                                } else {
                                  terms = false;
                                }
                              });
                            },
                            child: CustomText(
                              text: translate(LocaleKeys.termsConditions),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: ColorManager.primaryColor,
                                      height: 1.2,
                                      decoration: TextDecoration.underline),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Switch.adaptive(
                            value: isSwitched1,
                            onChanged: (value) {
                              setState(() {
                                isSwitched1 = value;
                                if (kDebugMode) {
                                  print("switch $isSwitched1");
                                }
                              });
                            },
                            //activeTrackColor: isSwitched ?ColorManager.primary:ColorManager.iconColor,
                            activeColor: ColorManager.primaryColor,
                            //  trackColor: ColorManager.iconColor,
                          ),
                        ],
                      ),

                      terms
                          ? CustomText(
                              text: translate(LocaleKeys.termsMessage),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: ColorManager.primaryColor),
                            )
                          : const SizedBox(),
                      const VerticalSpace(40),

                      Consumer<SellChangeCarViewModel>(
                        builder: (_, data, __) {
                          if (data.isLoading) {
                            return MyProgressIndicator(
                              height: 80.h,
                              width: 80.h,
                            );
                          } else {
                            return CustomButton(
                                buttonText: translate(LocaleKeys.ok),
                                onTap: () {
                                  _submit(context);
                                });
                          }
                        },
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ];

  Future<void> _submit(
    context,
  ) async {
    formData = {
      "brand_id": _selectedBrand,
      "car_model_id": _selectedModel,
      "car_model_extension_id": _selectedClass,
      "year": _selectedYear,
      "mileage": _mileageController.text,
      "city_id": _selectedCity,
      "name": _nameController.text,
      "phone": _phoneController.text,
    };

    final sellChangeCarProvider =
        Provider.of<SellChangeCarViewModel>(context, listen: false);
    if (!kDebugMode) {
      ResponseModel responseModel = await sellChangeCarProvider.sellChangeCar(
          context: context, formData: formData);
      print('responseModel.data ${responseModel.message}');
      if (responseModel.isSuccess) {
        showCustomSnackBar(
            isError: false,
            message: responseModel.message ?? "",
            context: context);
        //NavigationService.pushReplacement(context, Routes.homeScreen)
        NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
      } else {
        showCustomSnackBar(
            message: "${responseModel.message}", context: context);
      }
    } else {
      FocusScope.of(context).unfocus();
      if (_key.currentState!.validate()) {
        //   _key.currentState!.save();
        //   if (isSwitched1) {
        //     setState(() {
        //       terms =false ;
        //     });
        //     ResponseModel responseModel = await sellChangeCarProvider.sellChangeCar(
        //         context: context, formData: formData);
        //     if (responseModel.isSuccess) {
        //       NavigationService.goBack(context) ;
        //       showCustomSnackBar(
        //           message: "You have booked examination successfully",
        //           context: context);
        //       NavigationService.pushReplacement(
        //           context, Routes.bottomNavigationBar);
        //     } else {
        //       showCustomSnackBar(
        //           message: "${responseModel.message}", context: context);
        //     }
        //   } else {
        //     setState(() {
        //       terms =true ;
        //     });
        //
        // }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CarBrandsViewModel>(context, listen: false)
        .getBrands(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: MyAppbar(
            title: translate(LocaleKeys.sellChangeCat),
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
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Theme(
              data: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: ColorManager.primaryColor,
                ),
              ),
              child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                onStepTapped: (int position) {
                  if (currentStep < position) {
                    //alert(msg: "please complete the form then click continue");
                    showCustomSnackBar(
                        message: "please complete the form then click continue",
                        context: context);
                  } else {
                    setState(() {
                      currentStep = position;
                    });
                  }
                },
                onStepContinue: () {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (isLastStep) {
                    setState(() {
                      isCompleted = true;
                    });

                    showCustomSnackBar(message: "Completed", context: context);
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  setState(() {
                    currentStep == 0 ? null : currentStep -= 1;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return const Center();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
