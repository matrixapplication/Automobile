import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_model_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/filter_page/view_model/brandModelChnageViewModel.dart';
import 'package:automobile_project/presentation/filter_page/view_model/filter_page_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../bottom_navigation_bar/pages/sell_cars/view_model/filter_view_model.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/components.dart';
import '../../component/cutom_shimmer_image.dart';

class FilterPage extends StatefulWidget {
  final String? type  ;
  const FilterPage({Key? key, this.type}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? _selectedStartYear;
  String? _selectedEndYear;
  String? startPrice  ;
  String? endPrice  ;

  String? _selectedBrandModelExtension ;
  String? condition  = null ;
  String? brand  = null ;
  String? transimtionData  = null ;
  String? fuelTypData  = null ;



  List<String> years = [
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
    '1999',
    '1998',
    '1997',
    '1996',
    '1995',
    '1994',
    '1993',
    '1992',
    '1991',
    '1990'
  ];

  int transmissionTabsIndex = 0;
  String? driverType  = null;
  String? fuelType  = null ;

  int fuelTabsIndex = 0;
  List<String> transmissionTypeTabs = [
    translate(LocaleKeys.all),
    translate(LocaleKeys.manual),
    translate(LocaleKeys.automatic),

  ];
  List<String> fuelTypeTabs = [
    translate(LocaleKeys.all),
    translate(LocaleKeys.gas),
    translate(LocaleKeys.diesel),
    translate(LocaleKeys.naturalGas),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.type =="used"){
      Provider.of<BrandModelChangeViewModel>(context , listen: false).changeStatusIndex("used") ;
    }else if(widget.type == "new"){
      Provider.of<BrandModelChangeViewModel>(context , listen: false).changeStatusIndex("new") ;

    }else{
      Provider.of<BrandModelChangeViewModel>(context , listen: false).changeStatusIndex(null) ;
    }
  }
///////////////////////////////filter////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child:
      MyAppbar(
        title: translate(LocaleKeys.filter),
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,
        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child:Icon(Icons.arrow_forward_ios , color: ColorManager.white, textDirection: shared!.getString("lang") == "ar" ? TextDirection.ltr : TextDirection.rtl,)),
      )),
      body:   SizedBox(
        height: deviceHeight * 0.87,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w, vertical: 10.h),
                child: CustomText(
                    text: translate(LocaleKeys.carStatus),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.greyColor919191)),
              ),
              Consumer<BrandModelChangeViewModel>(
                builder: (_ , data , __ ){
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child:  Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                              radius: 0.0,
                              buttonText: translate(LocaleKeys.kNew),
                              textColor:data.statusIndex ==null ? ColorManager.black: data.statusIndex == "new" ? ColorManager.white : ColorManager.black ,
                              backgroundColor: data.statusIndex ==null ?  ColorManager.greyCanvasColor: data.statusIndex == "new" ? ColorManager.primaryColor : ColorManager.greyCanvasColor,
                              onTap: (){
                                data.changeStatusIndex("new")  ;
                                condition = "new" ;

                              },
                            )),
                        const HorizontalSpace(10),
                        Expanded(
                            child: CustomButton(
                              textColor:data.statusIndex ==null ? ColorManager.black: data.statusIndex == "used" ? ColorManager.white : ColorManager.black  ,
                              backgroundColor: data.statusIndex ==null ? ColorManager.greyCanvasColor: data.statusIndex == "used" ? ColorManager.primaryColor : ColorManager.greyCanvasColor,
                              radius: 0.0,
                              buttonText: translate(LocaleKeys.kUsed),
                              onTap: (){
                                data.changeStatusIndex("used")  ;
                                condition = "used" ;


                              },
                            ))
                      ],
                    ),
                  ) ;
                },
              ),
              const MyDivider(),
              Consumer<CarBrandsViewModel>(
                builder: (_ , data , __){
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                              text: translate(LocaleKeys.carBrand),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorManager.greyColor919191)),
                        ),

                      ],
                    ),
                  ) ;
                },
              ),
              Consumer<CarBrandsViewModel>(
                  builder: ( _ , data ,  __){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: SizedBox(
                        height: 50.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount:  data.getBrandsResponse?.data?.length ?? 0,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemBuilder: (context, index) {
                            return Consumer <BrandModelChangeViewModel>(
                              builder: (_ , value , __){
                                return TapEffect(onClick: (){
                                  value.changeBrandIndex("${data.getBrandsResponse?.data?[index].id}") ;
                                  brand  = data.getBrandsResponse?.data?[index].id.toString() ;
                                 setState(() {
                                   _selectedBrandModelExtension = null ;
                                   Provider.of<CarBrandsModelViewModel>(context,
                                       listen: false)
                                       .getBrandsModels(
                                       context: context,
                                       brandId: int.parse(brand.toString()));
                                 });
                                },
                                    child: Container(
                                      height: 40.h,
                                      padding: EdgeInsets.all(3.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: value.brandIndex == data.getBrandsResponse?.data?[index].id.toString() ?
                                          ColorManager.primaryColor : ColorManager.greyColorCBCBCB,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100.r),
                                        child:  CustomShimmerImage(
                                          image:
                                          "${data.getBrandsResponse?.data?[index].image}",
                                          boxFit: BoxFit.contain,
                                          height: 40.h,
                                          width: 40.w,
                                        ),
                                      ),
                                    )) ;
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const HorizontalSpace(10);
                          },
                        ),
                      ),
                    ) ;
                  }),
              // Consumer<GetMyCarsViewModel>(
              //   builder: (_ , data , __){
              //     return data.showRoomsBranchesResponse != null && data.showRoomsBranchesResponse!.data!.length > 10 ? Padding(
              //       padding: EdgeInsets.symmetric(
              //           vertical: 10.h, horizontal: 30.w),
              //       child: SizedBox(
              //           height: 50.h,
              //           child: const CustomButton(
              //             buttonText: "Show Models",
              //           )),
              //     )  : const SizedBox();
              //   },
              // ),
              const MyDivider(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                        text: translate(LocaleKeys.carModel),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.greyColor919191)),
                    SizedBox(
                      height: 8.h,
                    ) ,
                    Consumer<CarBrandsModelViewModel>(
                      builder: (_, extentions, ch) => Container(
                        height: 60.h,

                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                color: ColorManager.greyColorCBCBCB,
                                width: AppSize.s1)),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: DropdownButton(
                          value: _selectedBrandModelExtension,
                          focusColor: Colors.yellow,
                          iconEnabledColor: ColorManager.greyColorCBCBCB,
                          //itemHeight: 55.0,
                          isExpanded: true,

                          //value: dropdownValue,
                          icon: extentions.isLoading
                              ? const MyProgressIndicator(
                            width: 30,
                            height: 30,
                            size: 30,
                          )
                              : const Icon(
                            Icons.keyboard_arrow_down,
                            color: ColorManager.greyColorCBCBCB,
                          ),
                          iconSize: 30,
                          //style: Theme.of(context).textTheme.headline5,
                          hint: CustomText(
                              text: translate(LocaleKeys.selectBrand),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeightManager.light,
                                  color: ColorManager.greyColor919191)),
                          onChanged: (newValue) {
                            setState(() {
                              print(newValue) ;
                              _selectedBrandModelExtension = newValue.toString();
                            });
                          },
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),

                          items: extentions.getBrandModelsResponse?.data
                              ?.map<DropdownMenuItem<String>>((BasicModel value) {
                            return DropdownMenuItem<String>(
                              //for make on change Return id
                              value: value.id!.toString(),
                              child: CustomText(
                                  text: value.name!.toString(),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: ColorManager.black)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              const MyDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomText(
                    text: translate(LocaleKeys.price),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.greyColor919191)),
              ),
              SizedBox(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      height: 60.h,
                      width: 180.w,
                      textInputType: TextInputType.number,
                      contentVerticalPadding: 17.h,
                      hintText: translate(LocaleKeys.startPrice),
                      fillColor: ColorManager.greyCanvasColor,

                      borderRadius: 15.h,
                      onChange: (String? value){
                        startPrice = value  ;
                      },

                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    CustomTextField(
                      height: 60.h,
                      width: 180.w,

                      textInputType: TextInputType.number,
                      contentVerticalPadding: 17.h,
                      fillColor: ColorManager.greyCanvasColor,

                      hintText: translate(LocaleKeys.endPrice),
                      borderRadius: 15.h,
                      onChange: (String? value){
                        endPrice = value  ;
                      },

                    ),
                  ],
                ),
              ),


              const MyDivider(),



              Consumer<BrandModelChangeViewModel>(builder: (_ , data , __){
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                  color: ColorManager.greyColor919191)),
                          child: DropdownButton(
                            value: _selectedStartYear,
                            focusColor: Colors.yellow,
                            iconEnabledColor: Colors.red,
                            //itemHeight: 55.0,
                            isExpanded: true,
                            //value: dropdownValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorManager.primaryColor,
                            ),
                            iconSize: 30,
                            //style: Theme.of(context).textTheme.headline5,
                            hint: CustomText(
                              text: translate(LocaleKeys.startYear),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  color: ColorManager.greyColor919191),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedStartYear = newValue.toString();

                                data.startYearSelect(_selectedStartYear) ;
                                debugPrint("_selected Group Id $newValue");
                              });
                            },
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            items: years.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    //for make on change Return id
                                    value: value.toString(),
                                    child: CustomText(
                                        text: value,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                            color: ColorManager.black)),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      HorizontalSpace(20.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                  color: ColorManager.greyColor919191)),
                          child: DropdownButton(
                            value: _selectedEndYear,
                            focusColor: Colors.yellow,
                            iconEnabledColor: Colors.red,
                            //itemHeight: 55.0,
                            isExpanded: true,
                            //value: dropdownValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorManager.primaryColor,
                            ),
                            iconSize: 30,
                            //style: Theme.of(context).textTheme.headline5,
                            hint: CustomText(
                              text: translate(LocaleKeys.endYear),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  color: ColorManager.greyColor919191),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedEndYear = newValue.toString();
                                data.endYearSelect(_selectedEndYear) ;
                                debugPrint("_selected Group Id $newValue");
                              });
                            },
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            items: years.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    //for make on change Return id
                                    value: value.toString(),
                                    child: CustomText(
                                        text: value,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                            color: ColorManager.black)),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) ;
              }),
              const MyDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomText(
                    text: translate(LocaleKeys.carTransmission),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.greyColor919191)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: DefaultTabController(
                  //  length: 3,
                  length: 3,
                  initialIndex: transmissionTabsIndex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        onTap: (selectedTabIndex) {
                          setState(() {
                            transmissionTabsIndex = selectedTabIndex;
                            print(transmissionTabsIndex) ;
                            if(transmissionTabsIndex == 0){
                              driverType = "" ;
                            }else if(transmissionTabsIndex == 1 ){
                              driverType = "manual" ;

                            }else{
                              driverType = "automatic" ;

                            }

                          });
                        },
                        indicatorPadding: EdgeInsets.all(5.h),
                        indicator: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                        ),
                        indicatorColor: ColorManager.primaryColor,
                        labelColor: ColorManager.black,
                        unselectedLabelColor: Colors.black,
                        padding: EdgeInsets.all(10.h),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(),
                        unselectedLabelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                            fontWeight: FontWeightManager.semiBold,
                            letterSpacing:
                            0.1 // color: ColorManager.black
                        ),
                        tabs: <Widget>[
                          //     for (int index = 0; index < 3; index++)
                          for (int index = 0; index < 3; index++)
                            Tab(

                              child: CustomText(
                                text: transmissionTypeTabs[index],
                                maxLines: 1,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                    color:
                                    transmissionTabsIndex == index
                                        ? ColorManager.white
                                        : ColorManager
                                        .blackColor1C1C1C,
                                    fontWeight:
                                    FontWeightManager.semiBold,
                                    letterSpacing:
                                    0.1 // color: ColorManager.black
                                ),
                              ),

                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const MyDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomText(
                    text: translate(LocaleKeys.fuelType),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.greyColor919191)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: DefaultTabController(
                  //  length: 3,
                  length: 4
                  ,

                  initialIndex: transmissionTabsIndex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        onTap: (selectedTabIndex) {
                          setState(() {
                            fuelTabsIndex = selectedTabIndex;
                            if(selectedTabIndex == 0 ){
                              fuelType = null ;
                            }else if(selectedTabIndex == 1){
                              fuelType = 'gasoline' ;
                            }else if(selectedTabIndex == 2){
                              fuelType = 'diesel' ;
                            }else{
                              fuelType = 'natural_gas' ;
                            }
                          });
                        },
                        indicatorPadding: EdgeInsets.all(5.h),
                        indicator: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                        ),
                        indicatorColor: ColorManager.primaryColor,
                        labelColor: ColorManager.black,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,

                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(),
                        unselectedLabelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                            fontWeight: FontWeightManager.semiBold,
                            letterSpacing:
                            0.1 // color: ColorManager.black
                        ),
                        tabs: <Widget>[
                          //     for (int index = 0; index < 3; index++)
                          for (int index = 0; index < 4; index++)
                            Tab(
                              child: CustomText(
                                text: fuelTypeTabs[index],
                                maxLines: 1,

                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                    color: fuelTabsIndex == index
                                        ? ColorManager.white
                                        : ColorManager
                                        .blackColor1C1C1C,
                                    fontWeight:
                                    FontWeightManager.semiBold,
                                    letterSpacing:
                                    0.1 // color: ColorManager.black
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const MyDivider(),
              Consumer<FilterPageViewModel>(builder: (_ , viewModel , __){
                return !viewModel.isLoading?
                  TapEffect(onClick: ()async{
                   try{
                     await viewModel.getMyCars(context: context,
                         states: condition,
                         brand: brand,
                         search: null,
                         driveType: driverType,
                         fuelType: fuelType,
                         startPrice: startPrice,
                         endPrice: endPrice,
                         startYear: _selectedStartYear,
                         endYear: _selectedEndYear ,
                         carModel: _selectedBrandModelExtension,
                         isAll: true).then((value) => NavigationService.push(context, Routes.filtersCarsDetails , arguments: {
                       "name" : null ,
                       "id" : null  ,
                     } )) ;
                   }catch(e){
                     print(e);
                   }
                  },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          height: 60.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: translate(LocaleKeys.showResults),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: 18.sp,
                                      color: ColorManager.white)),

                            ],
                          ),
                        ),
                      )) : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyProgressIndicator(
                      height: 60.h,
                      width: 60.h,

                    )
                  ],
                ) ;
              })  , 
              VerticalSpace(20.h)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      context: context,
      builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 7.h,
                width: deviceWidth * 0.30,
                decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(10.r))),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Consumer<FilterViewModel>(
                builder: (_, myData, ch) => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: myData.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = myData.items[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Card(
                        child: ExpansionTile(
                          collapsedIconColor: ColorManager.primaryColor,
                          collapsedTextColor: ColorManager.primaryColor,
                          iconColor: ColorManager.primaryColor,
                          trailing: SizedBox(
                            width: 100.w,
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: ColorManager.primaryColor,
                                  value: myData.selectedItems
                                      .contains(item['title']),
                                  onChanged: (value) {
                                    myData.updateBrands(value!, item['title']);
                                  },
                                ),
                                const HorizontalSpace(8),
                                const Icon(Icons.expand_circle_down_outlined)
                              ],
                            ),
                          ),
                          title: Row(
                            children: [
                              CustomShimmerImage(
                                image:
                                index == 1 ?"https://w7.pngwing.com/pngs/173/877/png-transparent-opel-logo-icon.png":  "https://w7.pngwing.com/pngs/509/532/png-transparent-volkswagen-group-car-logo-volkswagen-car-logo-brand-emblem-trademark-volkswagen-thumbnail.png",
                                height: 30.h,
                                width: 30.h,
                                boxFit: BoxFit.cover,
                              ),
                              const HorizontalSpace(20),
                              CustomText(
                                text: item['title'],
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeightManager.semiBold),
                              )
                            ],
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: item['subItems'].length,
                              itemBuilder:
                                  (BuildContext context, int subIndex) {
                                final subItem = item['subItems'][subIndex];
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 53.w),
                                  child: CheckboxListTile(
                                    activeColor: ColorManager.primaryColor,
                                    title:Row(
                                      children: [
                                        CustomShimmerImage(
                                          image:
                                          index == 1 ?"https://w7.pngwing.com/pngs/173/877/png-transparent-opel-logo-icon.png":"https://w7.pngwing.com/pngs/509/532/png-transparent-volkswagen-group-car-logo-volkswagen-car-logo-brand-emblem-trademark-volkswagen-thumbnail.png",
                                          height: 25.h,
                                          width: 25.h,
                                          boxFit: BoxFit.cover,
                                        ),

                                       const HorizontalSpace(15),
                                        CustomText(
                                          text: subItem,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              fontWeight: FontWeightManager.semiBold),
                                        ),
                                      ],
                                    ) ,
                                    value:
                                        myData.selectedItems.contains(subItem),
                                    onChanged: (value) {
                                      setState(() {
                                        myData.updateBrands(value!, subItem);
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: const Divider(
        color: ColorManager.greyColor919191,
      ),
    );
  }
}
