// ignore_for_file: use_build_context_synchronously

import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/body_shape_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brand_model_extension_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_model_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_colors_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/fuel_types_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/years_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/components.dart';
import '../../component/custom_button.dart';
import '../../component/cutom_shimmer_image.dart';

class MyCarsToSellPage extends StatefulWidget {
  const MyCarsToSellPage({Key? key}) : super(key: key);

  @override
  State<MyCarsToSellPage> createState() => _MyCarsToSellPageState();
}

class _MyCarsToSellPageState extends State<MyCarsToSellPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userProvider = Provider.of<LocalAuthProvider>(context, listen: false);

    print(shared!.getString("role"));
    print(userProvider.user!.id!);
    Provider.of<GetMyCarsViewModel>(context, listen: false).getMyCars(
        context: context,
        id: shared?.getString("role") == "showroom" ||
                shared?.getString("role") == "agency"
            ? userProvider.user!.id!
            : userProvider.endUser!.id!,
        modelRole: shared?.getString("role") == "showroom" ||
                shared?.getString("role") == "agency"
            ? userProvider.user!.role!
            : "user",
        states: null,
        isAll: true);
    _controller.addListener(() {
      // if reach to end of the list\
      if (_controller.position.maxScrollExtent == _controller.offset) {
        // fetch();
        Provider.of<GetMyCarsViewModel>(context, listen: false).getMyCars(
          context: context,
          id: shared?.getString("role") == "showroom" ||
                  shared?.getString("role") == "agency"
              ? userProvider.user!.id!
              : userProvider.endUser!.id!,
          modelRole: shared?.getString("role") == "showroom" ||
                  shared?.getString("role") == "agency"
              ? userProvider.user!.role!
              : "user",
          states: null,
        );
        print("Fetch");
      } else {
        print("Not Fetch");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sellCarProvider =
        Provider.of<ShowRoomSellCarViewModel>(context, listen: true);
    final userProvider = Provider.of<LocalAuthProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: MyAppbar(
            title: translate(LocaleKeys.myCars),
            centerTitle: true,
            titleColor: ColorManager.white,
            backgroundColor: ColorManager.primaryColor,
            leading: shared!.getString("role") == "user"
                ? TapEffect(
                    onClick: () {
                      NavigationService.goBack(context);
                    },
                    child:  Icon(Icons.arrow_back_ios , color: ColorManager.white, textDirection: shared!.getString("lang") == "ar" ? TextDirection.ltr : TextDirection.rtl,))
                : TapEffect(
                    onClick: () {
                      NavigationService.push(
                          context, Routes.bottomNavigationBar);
                    },
                    child:  Icon(Icons.arrow_back_ios , color: ColorManager.white,textDirection: shared!.getString("lang") == "en"? TextDirection.rtl : TextDirection.ltr,)),
          )),
      body: Consumer<GetMyCarsViewModel>(
        builder: (_, data, __) {
          if (data.isLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: MyProgressIndicator(
                  size: 60,
                  height: 80.h,
                  width: 80.h,
                ),
              ),
            );
          } else if (data.carList.isEmpty) {
            return SizedBox(
              height: deviceHeight,
              child:  Center(
                child: CustomText(text: translate(LocaleKeys.dataNotFound)),
              ),
            );
          } else {
            return GridView.builder(
                controller: _controller,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (1 / 1.50).w,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: data.carList.length,
                itemBuilder: (ctx, index) => CarCard(index: index , carList: data.carList[index],));
          }
        },
      ),
    );
  }
}




class CarCard extends StatefulWidget {
  final int index ;
  final CarModel carList ;
  const CarCard({Key? key, required this.index, required this.carList}) : super(key: key);

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 0.h, horizontal: 0.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border:
          Border.all(color: ColorManager.greyColorCBCBCB)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              TapEffect(
                  onClick: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<CarBrandsViewModel>(
                        context,
                        listen: false)
                        .getBrands(context: context);
                    await Provider.of<CarBrandsModelViewModel>(
                        context,
                        listen: false)
                        .getBrandsModels(
                        context: context,
                        brandId:
                        widget.carList.brand!.id!);
                    await Provider.of<
                        CarBrandsModelExtensionViewModel>(
                        context,
                        listen: false)
                        .getBrandsModels(
                        context: context,
                        id: widget.carList.brandModel!
                            .id!);
                    await Provider.of<CarFeaturesViewModel>(
                        context,
                        listen: false)
                        .getCarFeatures(context: context);
                    await Provider.of<YearsViewModel>(context,
                        listen: false)
                        .getYears(context: context);
                    await Provider.of<CarColorsViewModel>(
                        context,
                        listen: false)
                        .getColors(context: context);
                    await Provider.of<
                        ShowRoomsBranchesViewModel>(
                        context,
                        listen: false)
                        .getBranches(context: context, id: 1);
                    print(widget.carList.toJson());
                    NavigationService.push(
                        context, Routes.updateCarPage,
                        arguments: {
                          "carModel": widget.carList
                        });
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CustomShimmerImage(
                        image:
                        "${widget.carList.mainImage}",
                        boxFit: BoxFit.cover,
                        height: 150.h,
                        width: double.infinity,
                      ),
                    ),
                  )),
              widget.carList.isBayed!
                  ? Container(
                width: 100.w,
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius:
                  BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: CustomText(
                    text: translate(LocaleKeys.soldOut),
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                        color: ColorManager.white),
                  ),
                ),
              )
                  : const SizedBox()
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widget.carList.brand?.name != null
                    ? CustomText(
                    text:
                    "${widget.carList.brand?.name} ${widget.carList.brandModel?.name} ${widget.carList.brandModelExtension?.name}",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                        height: 1.2,
                        color: ColorManager
                            .blackColor1C1C1C,
                        fontWeight:
                        FontWeightManager.semiBold))
                    : Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 14.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                        color:
                        ColorManager.greyColorCBCBCB,
                        borderRadius:
                        BorderRadius.circular(15.h)

                      // shape: BoxShape.circle
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          widget.carList.price != null
              ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                  text:
                  "${double.parse("${widget.carList.price}").toStringAsFixed(0)} EGP",
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                      color:
                      ColorManager.primaryColor,
                      fontSize: 28.h,
                      fontWeight:
                      FontWeightManager.bold,
                      height: 1))
            ],
          )
              : Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              height: 14.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: ColorManager.greyColorCBCBCB,
                  borderRadius:
                  BorderRadius.circular(15.h)
                // shape: BoxShape.circle
              ),
            ),
          ),
          VerticalSpace(10.h),
          !_isLoading
              ? CustomButton(
            buttonText: translate(LocaleKeys.edit),
            backgroundColor: ColorManager.primaryColor,
            height: 40.h,
            onTap: () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<CarBrandsViewModel>(
                  context,
                  listen: false)
                  .getBrands(context: context);
              await Provider.of<CarBrandsModelViewModel>(
                  context,
                  listen: false)
                  .getBrandsModels(
                  context: context,
                  brandId:
                  widget.carList.brand!.id!);
              await Provider.of<
                  CarBrandsModelExtensionViewModel>(
                  context,
                  listen: false)
                  .getBrandsModels(
                  context: context,
                  id: widget.carList.brandModel!
                      .id!);
              await Provider.of<CarFeaturesViewModel>(
                  context,
                  listen: false)
                  .getCarFeatures(context: context);
              await Provider.of<YearsViewModel>(context,
                  listen: false)
                  .getYears(context: context);
              await Provider.of<CarColorsViewModel>(
                  context,
                  listen: false)
                  .getColors(context: context);


              await Provider.of<BodyShapeViewModel>(context , listen: false).getBodyShape(context: context) ;
              await Provider.of<FuelTypeViewModel>(context , listen: false).getFuelType(context: context) ;
              if(shared!.getString("role")!= 'user'){
                await Provider.of<
                    ShowRoomsBranchesViewModel>(
                    context,
                    listen: false)
                    .getBranches(context: context, id: 1);
              }

              NavigationService.push(
                  context, Routes.updateCarPage,
                  arguments: {
                    "carModel": widget.carList
                  });
              setState(() {
                _isLoading = false;
              });
            },
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyProgressIndicator(
                color: ColorManager.primaryColor,
                size: 40.h,
              )
            ],
          ),
          VerticalSpace(10.h),
          CustomButton(
            buttonText: translate(LocaleKeys.soldOut),
            backgroundColor: widget.carList.isBayed!
                ? ColorManager.greyColor515151
                : ColorManager.orange,
            height: 40.h,
            onTap: !widget.carList.isBayed!
                ? () async {
              // await sellCarProvider.hideBranch(
              //     context: context,
              //     id: widget.carList.id!);
              // Provider.of<GetMyCarsViewModel>(context,
              //     listen: false)
              //     .getMyCars(
              //     context: context,
              //     id: shared?.getString("role") ==
              //         "showroom" ||
              //         shared?.getString("role") ==
              //             "agency"
              //         ? userProvider.user!.id!
              //         : userProvider.endUser!.id!,
              //     modelRole: shared?.getString(
              //         "role") ==
              //         "showroom" ||
              //         shared?.getString("role") ==
              //             "agency"
              //         ? userProvider.user!.role!
              //         : "user",
              //     states: null,
              //     isAll: true);
            }
                : () {},
          )
        ],
      ),
    );
  }
}
