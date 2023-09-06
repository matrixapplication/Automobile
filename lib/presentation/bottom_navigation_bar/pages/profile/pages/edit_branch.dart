import 'dart:io';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';

import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_districts_veiw_model.dart';

import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';

import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../core/resources/resources.dart';

import '../../../../component/components.dart';

import 'view_model/get_cities_view_model.dart';
class EditBranchBottomSheet extends StatefulWidget {
  final ShowRoomBranchModel model ;
  const EditBranchBottomSheet({Key? key, required this.model}) : super(key: key);

  @override
  State<EditBranchBottomSheet> createState() => _EditBranchBottomSheetState();
}

class _EditBranchBottomSheetState extends State<EditBranchBottomSheet> {
  String? _selectedCity ;
  String? _selectedDistrict ;
  Map<String , dynamic> formData = {
    "name" : null ,
    "name_en" : null ,
    "address" : null ,
    "address_en" : null ,
    "city_id" : null ,
    "district_id" : null ,
    "whatsapp" : null
  } ;
  final key = GlobalKey<FormState>() ;

  final TextEditingController nameArController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController addressArController = TextEditingController();
  final TextEditingController addressEnController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  Future<void> _submit(context,) async {
    final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: false) ;
    if (!key.currentState!.validate()) {
      debugPrint("Form Not Valid");
      return;
    }
    key.currentState!.save();
    ResponseModel result = await showRoomsProvider.editBranch(context: context, formData: formData, id: widget.model.id!) ;
    if(result.isSuccess){
      NavigationService.goBack(context);
      showCustomSnackBar(message: "Branch has been updated successfully", context: context) ;
    }else{
      showCustomSnackBar(message: "Something went Wrong !!", context: context) ;

    }
  }

  BasicModel ? cityData ;
  BasicModel ? districtData ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    nameArController.text = widget.model.name! ;
    nameEnController.text = widget.model.name! ;
    addressArController.text = widget.model.address! ;
    addressEnController.text = widget.model.address! ;
    phoneController.text = widget.model.phone?? '' ;
    whatsappController.text = widget.model.whatsapp??'' ;
    _selectedCity = widget.model.cityId.toString() ;
    _selectedDistrict = widget.model.districtId.toString() ;
    formData['phone'] = phoneController.text ;
    formData['whatsapp'] = whatsappController.text ;
    formData['city_id'] = widget.model.cityId;
    formData['district_id'] = widget.model.districtId ;

    cityData = BasicModel(id: int.parse(widget.model.cityId!), name: widget.model.city, brand: null
        , key: null, image: null, model: null, value: null, icon: null) ;

    districtData  =  BasicModel(id: int.parse(widget.model.districtId!), name: widget.model.district, brand: null
        , key: null, image: null, model: null, value: null, icon: null) ;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.h,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(translate(LocaleKeys.editBranch) , style: Theme.of(context).textTheme.titleLarge,) ,
            SizedBox(
              height: 10.h,
            ),

            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hintText:translate(LocaleKeys.nameAr),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.drive_file_rename_outline),
                    controller: nameArController,
                    onChange: (String? value){
                      formData['name'] = value ;
                    },
                    isValidator: true,
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }
                      return null  ;
                    },

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: translate(LocaleKeys.nameEn),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.drive_file_rename_outline),
                    controller: nameEnController,
                    onChange: (String? value){
                      formData['name_en'] = value ;
                    },
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }
                      return null  ;
                    },
                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: translate(LocaleKeys.addressAr),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.home_filled),
                    controller: addressArController,
                    onChange: (String? value){
                      formData['address'] = value ;
                    },
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }
                      return null  ;
                    },
                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: translate(LocaleKeys.addressEn),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.home_filled),
                    controller: addressEnController,
                    onChange: (String? value){
                      formData['address_en'] = value ;
                    },
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }else if(value.length  != 11){
                        return translate(LocaleKeys.phoneErrorMessage) ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: translate(LocaleKeys.phone),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.phone_android),
                    isPhoneNumber: true,
                    controller: phoneController,
                    onChange: (String? value){
                      formData['phone'] = value ;
                    },
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }
                      else if(value.length  != 11){
                        return translate(LocaleKeys.phoneErrorMessage) ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: translate(LocaleKeys.whatsApp),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.phone_android),
                    isPhoneNumber: true,
                    controller: whatsappController,
                    onChange: (String? value){
                      formData['whatsapp'] = value ;
                    },
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }
                      else if(value.length  != 11){
                        return translate(LocaleKeys.phoneErrorMessage) ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,









                ],
              ),
            ) ,
            Consumer<GetCitiesViewModel>(builder: (_, data, __) {
              return DropdownSearch<BasicModel>(
                asyncItems: (filter) async => data.getCitiesRespose!.data!,
                itemAsString: (BasicModel u) => u.name!,
                selectedItem: cityData,
                onChanged: (BasicModel? data) {
                  setState(() {
                    _selectedCity = data!.id.toString() ;
                    formData['city_id'] = _selectedCity ;

                    Provider.of<GetDistrictsViewModel>(context,
                        listen: false)
                        .getCities(
                        context: context,
                        id: data.id!);
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
                              color: ColorManager.greyCanvasColor, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor,
                              width: 2))),
                ),
                dropdownBuilder: (_, value) {
                  return _selectedCity != null ?
                  Row(
                    children: [

                      CustomText(
                        text: value?.name ?? '',
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ) :  Row(
                    children: [

                      CustomText(
                        text: translate(LocaleKeys.selectCity),
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  );
                },
                popupProps: PopupProps.menu(itemBuilder: (_, value, state) {
                  return Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: value.name ?? '',
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),

                      ],
                    ),
                  );
                }),
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




            SizedBox(
              height: 10.h,
            ),
            Consumer<GetDistrictsViewModel>(builder: (_, data, __) {
              return DropdownSearch<BasicModel>(
                asyncItems: (filter) async => data.getCitiesRespose!.data!,
                itemAsString: (BasicModel u) => u.name!,
                selectedItem: districtData,
                onChanged: (BasicModel? data) {
                  setState(() {
                    _selectedDistrict = data!.id.toString() ;
                    formData['district_id'] = _selectedDistrict            ;

                  });
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      labelText: translate(LocaleKeys.selectDistrict),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: ColorManager.primaryColor),
                      fillColor: ColorManager.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: ColorManager.greyCanvasColor,
                              width: 2))),
                ),
                dropdownBuilder: (_, value) {
                  return _selectedDistrict != null ?
                  Row(
                    children: [

                      CustomText(
                        text: value?.name ?? '',
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ) :  Row(
                    children: [

                      CustomText(
                        text: translate(LocaleKeys.selectDistrict),
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  );
                },
                popupProps: PopupProps.menu(itemBuilder: (_, value, state) {
                  return Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: value.name ?? '',
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),

                      ],
                    ),
                  );
                } ,
                    fit: FlexFit.loose
                ),
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



            SizedBox(
              height: 20.h,
            ) ,

            Consumer<ShowRoomsBranchesViewModel>(
                builder:
                    (_ , data , __ ){
                  if(data.isLoading){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyProgressIndicator(
                          height: 80.h,
                          width: 80.h,
                        )
                      ],
                    ) ;
                  }else{
                    return CustomButton(
                      height: 60.h,
                      padding: EdgeInsets.all(10.w),
                      width: 420.w,
                      onTap: (){
                        _submit(context) ;
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      buttonText: translate(LocaleKeys.edit),
                      radius: 10.h,

                    );
                  }
                }
            ) ,
          ],
        ),
      ),
    );
  }
}
