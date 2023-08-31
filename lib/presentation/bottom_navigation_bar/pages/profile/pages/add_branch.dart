import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/core/resources/app_assets.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/resources/app_values.dart';
import 'package:automobile_project/core/resources/font_manager.dart';
import 'package:automobile_project/core/resources/spaces.dart';
import 'package:automobile_project/data/models/base_response/base_model.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_cities_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_districts_veiw_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/presentation/component/text_icon.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:provider/provider.dart';
class AddBranchBottomSheet extends StatefulWidget {
  final String? selectedCity ;
  final String? selectedisterct ;
  const AddBranchBottomSheet({Key? key, this.selectedCity, this.selectedisterct}) : super(key: key);

  @override
  State<AddBranchBottomSheet> createState() => _AddBranchBottomSheetState();
}

class _AddBranchBottomSheetState extends State<AddBranchBottomSheet> {
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

  final TextEditingController nameArController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController addressArController = TextEditingController();
  final TextEditingController addressEnController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCity = widget.selectedCity ;
    _selectedDistrict = widget.selectedisterct ;
    Provider.of<GetCitiesViewModel>(context , listen: false).getCities(context: context) ;
    Provider.of<GetDistrictsViewModel>(context , listen: false).getCitiesRespose?.data?.clear() ;

  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<void> _submit(context,) async {
    final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: false) ;
    if (!_key.currentState!.validate()) {
      debugPrint("Form Not Valid");
      return;
    }
    _key.currentState!.save();
    ResponseModel result = await showRoomsProvider.addBranch(context: context, formData: formData) ;
    if(result.isSuccess){
      NavigationService.goBack(context);

      showCustomSnackBar(message: result.message!, context: context) ;
    }else{
      showCustomSnackBar(message: result.message!, context: context) ;

    }
  }
  @override
  Widget build(BuildContext context) {
    final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: true) ;
    return SizedBox(
      height: 800.h,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(translate(LocaleKeys.addNewBranch) , style: Theme.of(context).textTheme.titleLarge,) ,
            SizedBox(
              height: 10.h,
            ),

            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hintText: translate(LocaleKeys.nameAr),
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
                    isPhoneNumber: true,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.phone_android),
                    controller: phoneController,
                    onChange: (String? value){
                      formData['phone'] = value ;
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
                    hintText: translate(LocaleKeys.whatsApp),
                    enabled: true,
                    contentVerticalPadding: 8.h,
                    fillColor: Colors.white,
                    borderRadius: 15.w,
                    hintWeight: FontWeight.bold,
                    prefixIcon:  const Icon(Icons.phone_android),
                    controller: whatsappController,
                    isPhoneNumber: true,
                    onChange: (String? value){
                      formData['whatsapp'] = value ;
                    },
                    validate: (String? value){
                      if(value == null || value.isEmpty){
                        return translate(LocaleKeys.required) ;
                      }

                      return null  ;
                    },

                    isValidator: true,

                  ) ,









                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            Consumer<GetCitiesViewModel>(builder: (_, data, __) {
              return DropdownSearch<BasicModel>(
                asyncItems: (filter) async => data.getCitiesRespose!.data!,
                itemAsString: (BasicModel u) => u.name!,
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
                      CustomShimmerImage(
                        image: value?.image ?? '',
                        height: 20,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text: value?.name ?? '',
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ) :  Row(
                    children: [

                      CustomText(
                        text:  translate(LocaleKeys.selectCity),
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
              height: 10.h,
            ),
            Consumer<GetDistrictsViewModel>(builder: (_, data, __) {
              return DropdownSearch<BasicModel>(
                asyncItems: (filter) async => data.getCitiesRespose!.data!,
                itemAsString: (BasicModel u) => u.name!,
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
                      CustomShimmerImage(
                        image: value?.image ?? '',
                        height: 20,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
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
                        CustomShimmerImage(
                          image: value.image ?? '',
                          height: 40.h,
                          width: 40.h,
                          boxFit: BoxFit.contain,
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
                      buttonText: translate(LocaleKeys.ok),
                      loading: showRoomsProvider.isLoading,
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