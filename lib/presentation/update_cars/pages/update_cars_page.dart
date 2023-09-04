
import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/resources/spaces.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/body_shape_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brand_model_extension_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_model_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_colors_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/fuel_types_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/years_view_model.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/custom_assets_image.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/custom_svg_image.dart';
import 'package:automobile_project/presentation/component/custom_text.dart';
import 'package:automobile_project/presentation/component/custom_text_field.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/component/indicator.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../data/provider/local_auth_provider.dart';
import '../../../../../domain/entities/add_car_entity/add_car_entity.dart';

class UpdateCarsPage extends StatefulWidget {
  final CarModel carModel;
  const UpdateCarsPage({Key? key, required this.carModel}) : super(key: key);

  @override
  State<UpdateCarsPage> createState() => _UpdateCarsPageState();
}

class _UpdateCarsPageState extends State<UpdateCarsPage> {
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedCarStatus;
  String? _selectedBrandModelExtension;
  String? _selectedYear;
  String? _selectedFuelType;
  String? _selectedColor;
  String? _selectedShowRoomBranch;

  bool? brandError = false;
  bool? modelError = false;
  bool? brandModelExtensionError = false;
  bool? carStatusError = false;
  bool? yearError = false;
  bool? fuelError = false;
  bool? showRoomBranchError = false;
  List selectedValues = [];
  List<String> transmissionTypeTabsIcon = [
    AssetsManager.manualIcon,
    AssetsManager.automaticIcon,
  ];
  List<String> bodyShapeTabsIcon = [
    AssetsManager.sedanIcon,
    AssetsManager.hatchbackIcon,
    AssetsManager.suvIcon,
  ];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _titleEnController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _kiloMetersController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _selectedCarCylindersController =
      TextEditingController();
  BasicModel? brandModel;
  BasicModel? brand;
  BasicModel? brandModelEx;
  BasicModel? carStatus;
  BasicModel? bodyShapeModel;
  int? carYear;
  BasicModel? fuelType;
  BasicModel? carColor;
  ShowRoomBranchModel? carBranches;
  @override
  void initState() {
    Provider.of<LocalAuthProvider>(context, listen: false)
        .getUserData()
        .then((value) {});
    Provider.of<LocalAuthProvider>(context, listen: false)
        .getEndUserData()
        .then((value) {});
    Provider.of<LocalAuthProvider>(context, listen: false).getUserRole();
    _selectedBrand = widget.carModel.brand?.id.toString();
    brand = BasicModel.fromJson(widget.carModel.brand!.toJson());

    _selectedModel = widget.carModel.brandModel?.id.toString();
    brandModel = BasicModel.fromJson(widget.carModel.brandModel!.toJson());

    // selectedValues = [widget.carModel.brandModelExtension?.name] ;
    _selectedYear = widget.carModel.year;
    carYear = int.parse(widget.carModel.year!);
    _selectedColor = widget.carModel.color!.id.toString();
    carColor = BasicModel.fromJson(widget.carModel.color!.toJson());
    _selectedBrandModelExtension =
        widget.carModel.brandModelExtension!.id.toString();
    brandModelEx =
        BasicModel.fromJson(widget.carModel.brandModelExtension!.toJson());
    bodyShapeModel  = BasicModel.fromJson(widget.carModel.bodyType!.toJson()) ;
    print("BodyShapID${widget.carModel.bodyType!.toJson()}");
    carBranches = ShowRoomBranchModel(
        id: widget.carModel.branch?.id,
        name:  widget.carModel.branch?.address,
        address:  widget.carModel.branch?.address,
        city:  widget.carModel.branch?.city,
        district:  widget.carModel.branch?.district,
        phone:  null,
        whatsapp:  null,
        cityId:  null,
        districtId:  null);
    _selectedFuelType = widget.carModel.fuelType?.key;
    fuelType = BasicModel.fromJson(widget.carModel.fuelType!.toJson());
    _selectedCarStatus = widget.carModel.status?.key;
    carStatus = BasicModel.fromJson(widget.carModel.status!.toJson());
    if(widget.carModel.branch != null){
      _selectedShowRoomBranch = widget.carModel.branch!.id.toString();

    }
    _priceController.text = widget.carModel.price.toString();
    _titleController.text = widget.carModel.title.toString();
    _titleEnController.text = widget.carModel.title.toString();

    print("role ===> ${widget.carModel.modelRole}");
    _selectedCarCylindersController.text = widget.carModel.cylinders.toString();
    if(widget.carModel.status?.key == "used"){
      _kiloMetersController.text = widget.carModel.mileage!;
    }
    _commentController.text = widget.carModel.description.toString();
    _capacityController.text = widget.carModel.engine.toString();
    _commentController.text = widget.carModel.description.toString();


    for(int i = 0 ; i < widget.carModel.features!.length ; i++){
      for(int j =0 ; j < widget.carModel.features![i].options!.length ; j++ ){
        Provider.of<CarFeaturesViewModel>(
            context,
            listen: false).updateBrands(true, widget.carModel.features![i].options![j].id!) ;
      }
    }

    Provider.of<CarMechanicalViewModel>(context, listen: false)
        .changeTransmissionIndex(widget.carModel.driveType?.key);
    Provider.of<BodyShapeViewModel>(context, listen: false)
        .changeBodyShapeIndex(widget.carModel.bodyType?.id.toString());

    super.initState();
  }

  Color getColorFromColorCode(String code, double op) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000)
        .withOpacity(op);
  }

  @override
  Widget build(BuildContext context) {
    final carMechanicalViewModel =
        Provider.of<CarMechanicalViewModel>(context, listen: false);
    final bodyShapeViewModel =
        Provider.of<BodyShapeViewModel>(context, listen: false);
    final localAuthProvider =
        Provider.of<LocalAuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child:  MyAppbar(
            title: translate(LocaleKeys.uploadCar),
            titleColor: ColorManager.white,
            backgroundColor: ColorManager.primaryColor,
            centerTitle: true,
          )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.r),
                topLeft: Radius.circular(30.r)),
            color: ColorManager.greyColorF4F4F4),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const VerticalSpace(20),
              const VerticalSpace(20),
              Consumer<CarBrandsViewModel>(builder: (_, data, __) {
                return DropdownSearch<BasicModel>(
                  asyncItems: (filter) async => data.getBrandsResponse!.data!,
                  itemAsString: (BasicModel u) => u.name!,
                  selectedItem: brand,
                  onChanged: (BasicModel? data) {
                    setState(() {
                      brandError = false;
                      _selectedBrand = data!.id!.toString();
                      brandModel = null;
                      _selectedModel = null;
                      _selectedBrandModelExtension = null;
                      selectedValues.clear();
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
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          )
                        : Row(
                            children: [
                               CustomAssetsImage(
                                image: AssetsManager.brandIcon,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomText(
                                text: translate(LocaleKeys.selectBrand),
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
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
                  } ,                         fit: FlexFit.loose
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
              brandError!
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
                  ignoring: data.getBrandModelsResponse != null ? false : true,
                  child: DropdownSearch<BasicModel>(
                    asyncItems: (filter) async =>
                        data.getBrandModelsResponse!.data!,
                    itemAsString: (BasicModel u) => u.name!,
                    selectedItem: brandModel,
                    onChanged: (BasicModel? data) {
                      setState(() {
                        _selectedModel = data!.id.toString();
                        brandModel = data;
                        _selectedBrandModelExtension = null;
                        brandModelEx = null;
                        modelError = false;
                        Provider.of<CarBrandsModelExtensionViewModel>(context,
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
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                 CustomAssetsImage(
                                  image: AssetsManager.carModel,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: translate(LocaleKeys.selectModel),
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
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
                    } ,                         fit: FlexFit.loose
                    ),
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
              modelError!
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
                  ignoring: data.getCarBrandsModelExtensionResponse != null
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
                        _selectedBrandModelExtension = data!.id.toString();
                        brandModelExtensionError = false;
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: translate(LocaleKeys.carModelExtention),
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
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: ColorManager.greyCanvasColor,
                                  width: 2))),
                    ),
                    dropdownBuilder: (_, value) {
                      return brandModelEx != null
                          ? Row(
                              children: [
                                CustomText(
                                  text: value?.name ?? '',
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
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
                                  text: translate(LocaleKeys.carModelExtention),
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
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
                    } ,                         fit: FlexFit.loose
                    ),
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
              brandModelExtensionError!
                  ? CustomText(
                      text: translate(LocaleKeys.required),
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: ColorManager.primaryColor),
                    )
                  : const SizedBox(),

              const VerticalSpace(20),

              shared!.getString("role") != 'user'
                  ? Consumer<CarStatusViewModel>(builder: (_, data, __) {
                      return IgnorePointer(
                        ignoring:
                            data.getCarStatusResponse != null ? false : true,
                        child: DropdownSearch<BasicModel>(
                          asyncItems: (filter) async =>
                              data.getCarStatusResponse!.data!,
                          itemAsString: (BasicModel u) => u.name!,
                          selectedItem: carStatus,
                          onChanged: (BasicModel? data) {
                            setState(() {
                              carStatus = data;
                              _selectedCarStatus = data!.key.toString();
                              carStatusError = false;
                            });
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                labelText: translate(LocaleKeys.carStatus),
                                enabled: data.getCarStatusResponse != null
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
                                ),
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
                                : SizedBox(
                                    height: 22.h,
                                  );
                          },
                          popupProps:
                              PopupProps.menu(itemBuilder: (_, value, state) {
                            return Padding(
                              padding: EdgeInsets.all(16.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: value.name ?? '',
                                    textStyle:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            );
                          } ,                         fit: FlexFit.loose
                              ),
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
                    })
                  : const SizedBox(),

              carStatusError!
                  ? CustomText(
                      text: translate(LocaleKeys.required),
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: ColorManager.primaryColor),
                    )
                  : const SizedBox(),

              shared!.getString("role") != 'user'
                  ? const VerticalSpace(20)
                  : const SizedBox(),

              Consumer<YearsViewModel>(builder: (_, data, __) {
                return IgnorePointer(
                  ignoring: data.getYearsResponse != null ? false : true,
                  child: DropdownSearch<int>(
                    asyncItems: (filter) async => data.getYearsResponse!.data!,
                    itemAsString: (int u) => u.toString(),
                    selectedItem: carYear,
                    onChanged: (int? data) {
                      setState(() {
                        carYear = data;
                        _selectedYear = data!.toString();
                        yearError = false;
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: translate(LocaleKeys.carYear),
                          enabled: data.getYearsResponse != null ? true : false,
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
                      return carYear != null
                          ? Row(
                              children: [
                                CustomText(
                                  text: value.toString(),
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            )
                          : SizedBox(
                              height: 22.h,
                            );
                    },
                    popupProps: PopupProps.menu(itemBuilder: (_, value, state) {
                      return Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: value.toString(),
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
                  ),
                );
              }),

              yearError!
                  ? CustomText(
                      text: translate(LocaleKeys.required),
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: ColorManager.primaryColor),
                    )
                  : const SizedBox(),

              const VerticalSpace(20),
              Row(
                children: [
                  CustomSvgImage(
                    image: AssetsManager.automaticIcon,
                    color: ColorManager.primaryColor,
                    height: 22.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                      text: translate(LocaleKeys.carTransmission),
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeightManager.semiBold)),
                ],
              ),

              const VerticalSpace(10),
              Consumer<CarMechanicalViewModel>(
                builder: (context, viewModel, child) => viewModel.isLoading
                    ? const Center(child: MyProgressIndicator())
                    : SizedBox(
                        height: 60.h,
                        width: double.infinity,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              viewModel.getMechanicalResponse!.data!.length,
                          itemBuilder: (context, index) {
                            return TapEffect(
                              onClick: () {
                                viewModel.changeTransmissionIndex(viewModel
                                    .getMechanicalResponse?.data?[index].key);
                              },
                              child: Container(
                                width: deviceWidth * 0.44,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                    color: viewModel.transmissionKey ==
                                            viewModel.getMechanicalResponse
                                                ?.data?[index].key
                                        ? ColorManager.primaryColor
                                        : ColorManager.white,
                                    border: Border.all(
                                        color: ColorManager.greyColorCBCBCB,
                                        width: AppSize.s1),
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: viewModel.getMechanicalResponse
                                              ?.data?[index].name ??
                                          "",
                                      maxLines: 1,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: viewModel
                                                          .transmissionKey ==
                                                      viewModel
                                                          .getMechanicalResponse
                                                          ?.data?[index]
                                                          .key
                                                  ? ColorManager.white
                                                  : ColorManager
                                                      .blackColor1C1C1C,
                                              fontWeight:
                                                  FontWeightManager.semiBold,
                                              letterSpacing:
                                                  0.1 // color: ColorManager.black
                                              ),
                                    ),
                                    const HorizontalSpace(20),
                                    CustomSvgImage(
                                      image: transmissionTypeTabsIcon[index],
                                      color: viewModel.transmissionKey ==
                                              viewModel.getMechanicalResponse
                                                  ?.data?[index].key
                                          ? ColorManager.white
                                          : ColorManager.blackColor1C1C1C,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return HorizontalSpace(10.sp);
                          },
                        ),
                      ),
              ),

              const VerticalSpace(20),
                  Consumer<BodyShapeViewModel>(
                      builder: (_, data, __) {
                        return IgnorePointer(
                          ignoring: data.getBodyShapeResponse != null
                              ? false
                              : true,
                          child: DropdownSearch<BasicModel>(
                            asyncItems: (filter) async =>
                            data.getBodyShapeResponse!.data!,
                            itemAsString: (BasicModel u) => u.name!,
                            selectedItem: bodyShapeModel,
                            onChanged: (BasicModel? data) {
                              setState(() {
                                bodyShapeModel = data ;

                              });
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText:translate(LocaleKeys.bodyShape),
                                  enabled:
                                  data.getBodyShapeResponse != null
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
                              return bodyShapeModel != null
                                  ? Row(
                                children: [
                                  CustomText(
                                    text: value?.name ?? '',
                                    textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                  )
                                ],
                              )
                                  : Row(
                                children: [
                                  CustomSvgImage(
                                    image: AssetsManager.hatchbackIcon,
                                    height: 22,
                                    color: ColorManager.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    text:   translate(LocaleKeys.bodyShape),
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

                                    CustomShimmerImage(image: "${value.icon}"  , height: 20.h) ,
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
                          ),
                        );
                      }),

              const VerticalSpace(20),
              Consumer<FuelTypeViewModel>(builder: (_, data, __) {
                return IgnorePointer(
                  ignoring: data.getFuelTypeResponse != null ? false : true,
                  child: DropdownSearch<BasicModel>(
                    asyncItems: (filter) async =>
                        data.getFuelTypeResponse!.data!,
                    itemAsString: (BasicModel u) => u.name!,
                    selectedItem: fuelType,
                    onChanged: (BasicModel? data) {
                      setState(() {
                        fuelType = data;
                        _selectedFuelType = data!.key.toString();
                        carStatusError = false;
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: translate(LocaleKeys.fuelType),
                          enabled:
                              data.getFuelTypeResponse != null ? true : false,
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
                      return fuelType != null
                          ? Row(
                              children: [
                                CustomText(
                                  text: value?.name ?? '',
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                const CustomAssetsImage(
                                  image: AssetsManager.fuelTypeIcon,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: translate(LocaleKeys.fuelType),
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
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
                  ),
                );
              }),

              const VerticalSpace(20),
              CustomText(
                  text: "${translate(LocaleKeys.engineCapacity)} (cc)",
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeightManager.semiBold)),
              const VerticalSpace(10),
              //capacity
              CustomTextField(
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return translate(LocaleKeys.required);
                  }
                  return null;
                },
                controller: _capacityController,
                hintText: translate(LocaleKeys.engineCapacity),
                textInputType: TextInputType.number,
                maxLine: 1,
                contentVerticalPadding: 17.h,
                borderColor: ColorManager.greyColorCBCBCB,
                borderRadius: 15.r,
              ),

              const VerticalSpace(20),
              CustomText(
                  text: translate(LocaleKeys.carCylinders),
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeightManager.semiBold)),
              const VerticalSpace(10),
              //capacity
              CustomTextField(
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return translate(LocaleKeys.required);
                  }
                  return null;
                },
                controller: _selectedCarCylindersController,
                hintText: translate(LocaleKeys.carCylinders),
                textInputType: TextInputType.number,
                maxLine: 1,
                contentVerticalPadding: 17.h,
                borderColor: ColorManager.greyColorCBCBCB,
                borderRadius: 15.r,
              ),
              const VerticalSpace(20),

              _selectedCarStatus == "used"
                  ? Row(
                      children: [
                        CustomAssetsImage(
                          image: AssetsManager.kilometersIcon,
                          width: 20.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                            text: "${translate(LocaleKeys.mileage)} (KM)",
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeightManager.semiBold))
                      ],
                    )
                  : const SizedBox(),

              _selectedCarStatus == "used"
                  ? const VerticalSpace(10)
                  : const SizedBox(),
              //Kilometers
              _selectedCarStatus == "used"
                  ? CustomTextField(
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return translate(LocaleKeys.required);
                        }
                        return null;
                      },
                      controller: _kiloMetersController,
                      hintText: "${translate(LocaleKeys.mileage)} (KM)",
                      textInputType: TextInputType.number,
                      maxLine: 1,
                      contentVerticalPadding: 17.h,
                      borderColor: ColorManager.greyColorCBCBCB,
                      borderRadius: 15.r,
                    )
                  : const SizedBox(),

              _selectedCarStatus == "used" || _selectedCarStatus == "new"
                  ? const VerticalSpace(20)
                  : const SizedBox(),

              Consumer<CarColorsViewModel>(builder: (_, data, __) {
                return IgnorePointer(
                  ignoring: data.getColorsResponse != null ? false : true,
                  child: DropdownSearch<BasicModel>(
                    asyncItems: (filter) async => data.getColorsResponse!.data!,
                    itemAsString: (BasicModel u) => u.name!,
                    selectedItem: carColor,
                    onChanged: (BasicModel? data) {
                      setState(() {
                        carColor = data;
                        _selectedColor = data!.id.toString();
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: translate(LocaleKeys.color),
                          enabled:
                              data.getColorsResponse != null ? true : false,
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
                      return carColor != null
                          ? Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager.greyCanvasColor),
                                      color: getColorFromColorCode(
                                          "${value != null ? value.value : translate(LocaleKeys.color)}",
                                          1),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: value?.name ?? '',
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                const CustomAssetsImage(
                                  image: AssetsManager.carIcon,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: translate(LocaleKeys.color),
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
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
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.greyCanvasColor),
                                  color: getColorFromColorCode(
                                      "${value.value}", 1),
                                  shape: BoxShape.circle),
                            ),
                          ],
                        ),
                      );
                    } ,                         fit: FlexFit.loose
                    ),
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

              const VerticalSpace(20),
              CustomText(
                  text: "${translate(LocaleKeys.price)} (EGP)",
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeightManager.semiBold)),

              const VerticalSpace(10),
              //Price (EGP)
              CustomTextField(
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return translate(LocaleKeys.required);
                  }
                  return null;
                },
                controller: _priceController,
                hintText: "${translate(LocaleKeys.price)} (EGP)",
                contentVerticalPadding: 17.h,
                textInputType: TextInputType.number,
                maxLine: 1,
                borderColor: ColorManager.greyColorCBCBCB,
                borderRadius: 14.r,
              ),

              localAuthProvider.user?.role == "showroom" ||
                      localAuthProvider.user?.role == "agency"
                  ? const VerticalSpace(10)
                  : const SizedBox(),

              const VerticalSpace(10),

              localAuthProvider.user?.role == "showroom" ||
                      localAuthProvider.user?.role == "agency"
                  ? Consumer<ShowRoomsBranchesViewModel>(
                      builder: (_, data, __) {
                      return IgnorePointer(
                        ignoring: data.showRoomsBranchesResponse != null
                            ? false
                            : true,
                        child: DropdownSearch<ShowRoomBranchModel>(
                          asyncItems: (filter) async =>
                              data.showRoomsBranchesResponse!.data!,
                          itemAsString: (ShowRoomBranchModel u) => u.name!,
                          selectedItem: carBranches,
                          onChanged: (ShowRoomBranchModel? data) {
                            setState(() {
                              carBranches = data;
                              _selectedShowRoomBranch = data!.id.toString();
                              showRoomBranchError = false;
                            });
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                labelText: translate(LocaleKeys.branches),
                                enabled: data.showRoomsBranchesResponse != null
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
                            return carBranches != null
                                ? Row(
                                    children: [
                                      CustomText(
                                        text:
                                            "${value?.city}, ${value?.district}, ${value?.name}",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    height: 22.h,
                                  );
                          },
                          popupProps:
                              PopupProps.menu(itemBuilder: (_, value, state) {
                            return Padding(
                              padding: EdgeInsets.all(16.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text:
                                        "${value.city},${value.district},${value.name}",
                                    textStyle:
                                        Theme.of(context).textTheme.titleLarge,
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
                        ),
                      );
                    })
                  : const SizedBox(),

              showRoomBranchError!
                  ? CustomText(
                      text: translate(LocaleKeys.required),
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: ColorManager.primaryColor),
                    )
                  : const SizedBox(),
              const VerticalSpace(10),
              CustomText(
                  text: translate(LocaleKeys.carDescription),
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeightManager.semiBold)),
              const VerticalSpace(10),
              //Comments
              CustomTextField(
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return translate(LocaleKeys.required);
                  }
                  return null;
                },
                contentVerticalPadding: 17.h,
                controller: _commentController,
                hintText: translate(LocaleKeys.carDescription),
                textInputType: TextInputType.text,
                maxLine: 3,
                borderColor: ColorManager.greyColorCBCBCB,
                borderRadius: 14.r,
              ),

              const VerticalSpace(30),
              Center(
                  child: CustomButton(
                buttonText: translate(LocaleKeys.chooseFeatures),
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          topLeft: Radius.circular(12.r)),
                    ),
                    context: context,
                    builder: (context) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 7.h,
                                  width: deviceWidth * 0.30,
                                  decoration: BoxDecoration(
                                      color: ColorManager.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r))),
                              CustomText(
                                  text: translate(LocaleKeys.chooseFeatures),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeightManager.bold)),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: Consumer<CarFeaturesViewModel>(
                                  builder: (_, data, ch) {
                                    return ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        itemCount: data.getCarFeaturesResponse
                                            ?.data?.length,
                                        shrinkWrap: true,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: 10.w),
                                                decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .greyColorCBCBCB,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r)),
                                                width: double.infinity,
                                                child: CustomText(
                                                    text: data
                                                            .getCarFeaturesResponse
                                                            ?.data?[index]
                                                            .name ??
                                                        "",
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .semiBold)),
                                              ),
                                              GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 4 / 1,
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10.w,
                                                    mainAxisSpacing: 5.h,
                                                  ),
                                                  itemCount: data
                                                      .getCarFeaturesResponse
                                                      ?.data?[index]
                                                      .options
                                                      ?.length,
                                                  itemBuilder: (ctx, i) => Row(
                                                        children: [
                                                          Expanded(
                                                            child: CustomText(
                                                                text: data
                                                                        .getCarFeaturesResponse
                                                                        ?.data?[
                                                                            index]
                                                                        .options?[
                                                                            i]
                                                                        .name ??
                                                                    "",
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith()),
                                                          ),
                                                          const HorizontalSpace(
                                                              5),
                                                          Checkbox(
                                                            activeColor:
                                                                ColorManager
                                                                    .primaryColor,
                                                            value: data
                                                                .selectedItems
                                                                .contains(data
                                                                    .getCarFeaturesResponse
                                                                    ?.data?[
                                                                        index]
                                                                    .options?[i]
                                                                    .id),
                                                            onChanged: (value) {
                                                              data.updateBrands(
                                                                  value!,
                                                                  data
                                                                      .getCarFeaturesResponse!
                                                                      .data![
                                                                          index]
                                                                      .options![
                                                                          i]
                                                                      .id!);
                                                            },
                                                          ),
                                                        ],
                                                      ))
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: TapEffect(
                                    onClick: () {},
                                    child: CustomButton(
                                      buttonText: translate(LocaleKeys.done),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: ColorManager.white),
                                      width: 390.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      radius: 15.r,
                                      onTap: () {
                                        NavigationService.goBack(context);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              )),

              const VerticalSpace(30),
              Center(
                  child: CustomButton(
                buttonText: translate(LocaleKeys.next),
                onTap: () {
                  if (kDebugMode) {
                    print(Provider.of<CarFeaturesViewModel>(context,
                            listen: false)
                        .selectedItems);
                    print(_selectedBrand);
                    print(_selectedModel);
                    print(_selectedCarStatus);
                    print(_selectedYear);
                    print(_selectedFuelType);
                    print(_selectedShowRoomBranch);
                    print(_selectedBrand);
                    print(_selectedBrand);
                  }

                  FocusScope.of(context).unfocus();
                  if (!_key.currentState!.validate() ||
                      Provider.of<CarFeaturesViewModel>(context, listen: false)
                          .selectedItems
                          .isEmpty ||
                      _selectedBrand == null ||
                      _selectedModel == null ||
                      _selectedCarStatus == null ||
                      _selectedYear == null ||
                      _selectedFuelType == null) {
                    setState(() {
                      if (_selectedBrand == null) {
                        brandError = true;
                      } else if (_selectedModel == null) {
                        modelError = true;
                      } else if (_selectedBrandModelExtension == null) {
                        brandModelExtensionError = true;
                      } else if (_selectedYear == null) {
                        yearError = true;
                      } else if (_selectedFuelType == null) {
                        fuelError = true;
                      } else if (_selectedCarStatus == null) {
                        carStatusError = true;
                      }
                    });

                    Alerts.showAppDialog(context,
                        alertTitle: translate(LocaleKeys.alert),
                        alertDescription: translate(LocaleKeys.carMissData),
                        onConfirm: () {},
                        confirmText: translate(LocaleKeys.ok),
                        withClose: false,
                        confirmTextColor: ColorManager.white);
                    debugPrint("Form Not Valid");
                    return;
                  }
                  if (kDebugMode) {
                    print("done validation");
                  }

                  _key.currentState!.save();
                  try{
                    NavigationService.push(context, Routes.updateCarPhotosPage,
                        arguments: {
                          "carData": SellCarEntity(
                            selectedOptions: Provider.of<CarFeaturesViewModel>(
                                context,
                                listen: false)
                                .selectedItems,
                            modelId: localAuthProvider.user?.role == "showroom" ||
                                localAuthProvider.user?.role == 'agency'
                                ? localAuthProvider.user?.id
                                : localAuthProvider.endUser?.id,
                            modelRole: localAuthProvider.role.toString(),
                            brandId: int.parse(_selectedBrand!),
                            carModelId: int.parse(_selectedModel!),
                            carModelExtensionId:
                            int.parse(_selectedBrandModelExtension!),
                            branchId: _selectedShowRoomBranch != null
                                ? int.parse(_selectedShowRoomBranch!)
                                : null,
                            year: int.parse(_selectedYear!),
                            color: _selectedColor,
                            driveType: carMechanicalViewModel.transmissionKey,
                            bodyType: bodyShapeModel?.id,
                            fuelType: _selectedFuelType,
                            status: _selectedCarStatus,
                            price: int.parse(_priceController.text),
                            doors: 4,
                            engine: int.parse(_capacityController.text),
                            cylinders:
                            int.parse(_selectedCarCylindersController.text),
                            mileage: int.tryParse(_kiloMetersController.text),
                            description: _commentController.text,
                            images: const [],
                          ),
                          "oldImages" : widget.carModel.images ,
                          "oldMainImage" : widget.carModel.mainImage ,
                          "id" : widget.carModel.id

                        });
                  }catch(e){
                    print(e);
                  }
                },
              )),
              const VerticalSpace(30),
            ]),
          ),
        ),
      ),
    );
  }
}
