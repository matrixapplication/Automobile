// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/filter_page/view_model/filter_page_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';
import '../../../../component/cutom_shimmer_image.dart';

class HomeBrandsComponent extends StatefulWidget {
  final String? role ;
  final String? status ;
  const HomeBrandsComponent({
    Key? key, required this.role, required this.status,
  }) : super(key: key);

  @override
  State<HomeBrandsComponent> createState() => _HomeBrandsComponentState();
}

class _HomeBrandsComponentState extends State<HomeBrandsComponent> {
  final _controller = ScrollController() ;
  bool clicked  = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0) , ()async{
      final brandsProvider = Provider.of<CarBrandsViewModel>(context , listen: false) ;
      brandsProvider.getBrands(context: context,);
    }) ;
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 60.h,
      child: Consumer<CarBrandsViewModel>(
        builder: (_ , data , __){
          return ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: data.getBrandsResponse?.data != null ?  data.getBrandsResponse!.data!.length : 3,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              return !data.isLoading ?
              GestureDetector(
                onTap: clicked  == false ?
                    () async {
                  setState(() {
                    clicked = true ;
                  });
                  print(data.getBrandsResponse?.data?[index].id) ;
                  final filterPageProvider = Provider.of<FilterPageViewModel>(context , listen:  false) ;
                  await filterPageProvider.getMyCars(context: context, states: null,
                      brand: data.getBrandsResponse?.data?[index].id.toString(), driveType: null, fuelType: null, startPrice: null, endPrice:null,carModel: null,
                      startYear: null, endYear: null, search: null , isAll: true);
                  NavigationService.push(context, Routes.filtersCarsDetails , arguments: {
                    "id" :data.getBrandsResponse?.data?[index].id ,
                    "name" : null
                  }) ;
                  setState(() {
                    clicked = false ;
                  });
                }:(){},
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.greyColor919191,
                    ),
                  ),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(60.r),
                    child: CustomShimmerImage(
                      image: "${data.getBrandsResponse?.data?[index].image}",
                      height: 40.h,
                      width: 40.h,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
              ) : MyProgressIndicator();
            },
            separatorBuilder: (BuildContext context, int index) {
              return const HorizontalSpace(10);
            },
          ) ;
        }
      ),
    );
  }
}
