// ignore_for_file: use_build_context_synchronously





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


class ShowAgencyBranches extends StatefulWidget {
  const ShowAgencyBranches({Key? key}) : super(key: key);

  @override
  State<ShowAgencyBranches> createState() => _ShowAgencyBranchesState();
}

class _ShowAgencyBranchesState extends State<ShowAgencyBranches> {
  late Future<ResponseModel<List<ShowRoomBranchModel>>> _roomBranchModel  ;
  String _selectedCity = "1" ;
  String _selecteddistrict = "1" ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 0) , ()async{
      final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: false) ;
      // final getCitiesProvider = Provider.of<GetCitiesViewModel>(context , listen: false) ;
      (await showRoomsProvider.getBranches(context: context, id: 1))  ;
      // await getCitiesProvider.getCities(context: context,) ;
      if (kDebugMode) {


      }

    }) ;

    Provider.of<GetCitiesViewModel>(context , listen: false).getCities(context: context) ;


  }

  @override
  Widget build(BuildContext context) {
    final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: true) ;

    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.myBranches),
        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.black,
            )),
      )) ,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // VerticalSpace(20.h) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TapEffect(
                      onClick: (){
                        showModalBottomSheet(context: context,
                            builder: (_)=> const AddBranchBottomSheet() ,
                            isScrollControlled: true,


                            backgroundColor: Colors.white ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.w) ,
                              topLeft: Radius.circular(15.w) ,
                            )
                          ) ,

                        ) ;
                      },
                      child: Container(
                        width: 380.w,
                        padding:  EdgeInsets.all(15.w) ,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor ,
                          borderRadius: BorderRadius.circular(10) ,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1) ,
                              blurRadius: 3 ,
                              offset: const Offset(0, 0) ,
                              spreadRadius: 3
                            )
                          ]
                        ),
                        child:  Center(
                          child: Text(translate(LocaleKeys.addNewBranch) , style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: FontSize.s18.sp,
                            color: ColorManager.white,
                          ), ),
                        ),
                      ),

                      ) ,




                ],
              ),
              // VerticalSpace(20.h) ,

              SizedBox(
                height: 20.h,
              ),

              showRoomsProvider.isLoading == false ?
              Column(
                children: List.generate(showRoomsProvider.showRoomsBranchesResponse!.data!.length, (index)
                => Container(
                  width: 380.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor ,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1) ,
                          spreadRadius: 1 ,
                          offset: const Offset(0, 0)
                        )
                      ]  ,
                    borderRadius: BorderRadius.circular(15.w)
                  ),
                   child: Column(
                     children:[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,

                         children: [
                           TextIconWidget(
                             icon: Icons.drive_file_rename_outline,

                             title: "${showRoomsProvider.showRoomsBranchesResponse!.data![index].name}",
                           ) ,

                           TapEffect(onClick: ()async{
                             await Provider.of<GetCitiesViewModel>(context , listen: false).getCities(context: context).then((value){


                             }) ;
                             await Provider.of<GetDistrictsViewModel>(context , listen: false)
                                 .getCities(context: context, id: int.parse(showRoomsProvider.showRoomsBranchesResponse!.data![index].cityId!)).then((value){


                             }) ;
                             showModalBottomSheet(context: context,
                               builder: (_)=>  EditBranchBottomSheet(model: showRoomsProvider.showRoomsBranchesResponse!.data![index]) ,
                               isScrollControlled: true,


                               backgroundColor: Colors.white ,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.only(
                                     topRight: Radius.circular(15.w) ,
                                     topLeft: Radius.circular(15.w) ,
                                   )
                               ) ,

                             ) ;
                           },
                               child: const Icon(Icons.edit_note_sharp , color: ColorManager.primaryColor,))
                         ],
                       ),
                       SizedBox(
                         height: 10.h,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           TextIconWidget(
                             icon: Icons.home_filled,

                             title: "${showRoomsProvider.showRoomsBranchesResponse!.data![index].address}",
                           ) ,
                           TapEffect(onClick: (){
                             showRoomsProvider.hideBranch(context: context, id: showRoomsProvider.showRoomsBranchesResponse!.data![index].id!) ;
                           }, child: const Icon(Icons.delete_forever , color: ColorManager.primaryColor,))
                         ],
                       ) ,
                       SizedBox(
                         height: 10.h,
                       ),
                       TextIconWidget(
                         icon: Icons.place,

                         title: "${showRoomsProvider.showRoomsBranchesResponse!.data![index].city},${showRoomsProvider.showRoomsBranchesResponse!.data![index].district}",
                       ) ,

                     ]
                   ),
                )
                ),
              ) : SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: MyProgressIndicator(
                    width: 80.h,
                    height: 80.h,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


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

      showCustomSnackBar(message: "Branch has been added successfully", context: context) ;
    }else{
      showCustomSnackBar(message: "Something went Wrong !!", context: context) ;

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
            Text("Add branch" , style: Theme.of(context).textTheme.titleLarge,) ,
            SizedBox(
              height: 10.h,
            ),

            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hintText: "name-ar",
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
                        return "required!" ;
                      }
                      return null  ;
                    },

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "name-en",
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
                        return "required!" ;
                      }
                      return null  ;
                    },
                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "address-ar",
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
                        return "required!" ;
                      }
                      return null  ;
                    },
                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "address-en",
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
                        return "required!" ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "phone number",
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
                        return "required!" ;
                      }
                      if(value.length < 11 ){
                        return "phone must be 11 numbers" ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "whatsapp",
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
                        return "required!" ;
                      }
                      if(value.length < 11 ){
                        return "phone must be 11 numbers" ;
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
                      labelText: "Select City",
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
                        text: 'Select city',
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
                      labelText: "Select District",
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
                        text: 'Select District',
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
                      buttonText: "Add",
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
            Text("Edit branch" , style: Theme.of(context).textTheme.titleLarge,) ,
            SizedBox(
              height: 10.h,
            ),

            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hintText: "name-ar",
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
                        return "required!" ;
                      }
                      return null  ;
                    },

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "name-en",
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
                        return "required!" ;
                      }
                      return null  ;
                    },
                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "address-ar",
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
                        return "required!" ;
                      }
                      return null  ;
                    },
                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "address-en",
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
                        return "required!" ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "phone number",
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
                        return "required!" ;
                      }
                      if(value.length < 11 ){
                        return "phone must be 11 numbers" ;
                      }
                      return null  ;
                    },

                    isValidator: true,

                  ) ,
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hintText: "whatsapp",
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
                        return "required!" ;
                      }
                      if(value.length < 11 ){
                        return "phone must be 11 numbers" ;
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
                      labelText: "Select City",
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
                        text: 'Select city',
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
                      labelText: "Select District",
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
                        text: 'Select District',
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
                      buttonText: "Edit",
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




