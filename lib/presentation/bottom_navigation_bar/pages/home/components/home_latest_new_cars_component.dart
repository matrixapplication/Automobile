import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/presentation/latest_new_cars/view_model/show_room_new_cars_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';
import '../../../../component/cutom_shimmer_image.dart';

class HomeLatestNewCarsComponent extends StatefulWidget {
  const HomeLatestNewCarsComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeLatestNewCarsComponent> createState() => _HomeLatestNewCarsComponentState();
}

class _HomeLatestNewCarsComponentState extends State<HomeLatestNewCarsComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewCarsShowRoomViewModel>(context , listen: false).getMyCars(context: context, id: null, modelRole: "", states: "new" ,isAll: true);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310.h,
      decoration: BoxDecoration(
        color: ColorManager.black
      ),
      child: Consumer<NewCarsShowRoomViewModel>(
        builder: (_ , data , __){
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.carList.isEmpty ?0 : data.carList.length > 6 ?  6: data.carList.length  ,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: 310.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: deviceWidth * 0.60,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),

                      border: Border.all(color: ColorManager.primaryColor)
                    ),
                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(12.r),

                      child: Stack(
                        children: [
                          Stack(
                            children: [
                             TapEffect(onClick: (){
                               NavigationService.push(
                                   context, Routes.latestNewCarsDetails  ,
                                   arguments: {
                                     "isShowRoom" : true ,
                                     "carModel" : data.carList[index]
                                   }
                               );
                             }, child:  Padding(
                               padding: EdgeInsets.only(bottom: 115.h , left: 10.h , right: 10.h , top: 10.h),
                               child:  CustomShimmerImage(
                                 image:
                                 "${data.carList[index].mainImage}",
                                 boxFit: BoxFit.cover,
                                 width: double.infinity,
                               ),
                             )),
                              data.carList[index].isBayed! ?
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 90.w,
                                  height: 40.h,
                                  padding: EdgeInsets.all(8.h),
                                  decoration: BoxDecoration(
                                    color: ColorManager.primaryColor ,
                                    borderRadius: BorderRadius.circular(15.r) ,
                                  ),
                                  child: Center(
                                    child: CustomText(text: translate(LocaleKeys.soldOut) , textStyle: Theme.of(context)
                                        .textTheme.bodySmall!.copyWith(
                                        color: ColorManager.white
                                    ),) ,
                                  ),
                                ),
                              ) : const SizedBox()


                            ],
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 155.h,
                              padding:
                              EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1) ,
                                      offset: const Offset(0, 0) ,
                                      spreadRadius: 6 ,
                                      blurRadius: 48
                                    )
                                  ],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    data.carList[index].brand?.name  != null ? CustomText(
                                        text:"${data.carList[index].brand?.name} ${data.carList[index].brandModel?.name} ${data.carList[index].brandModelExtension?.name}",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                            color: ColorManager.black,
                                            fontWeight: FontWeightManager.bold,
                                            height: 1.2),
                                        maxLines: 2) :  Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[600]!,
                                      child: Container(
                                        height: 14.h,
                                        width: 30.w,
                                        decoration:  BoxDecoration(
                                            color: ColorManager.greyColorCBCBCB,
                                            borderRadius: BorderRadius.circular(15.h)
                                          // shape: BoxShape.circle
                                        ),
                                      ),) ,

                                    SizedBox(
                                      height: 8.h,
                                    ) ,
                                    data.carList[index].price != null ?  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: "${double.parse("${data.carList[index].price}").toStringAsFixed(0)} EGP",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                color: ColorManager.primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeightManager.semiBold,
                                                height: 1)),
                                      ],
                                    )  : Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[600]!,
                                      child: Container(
                                        height: 14.h,
                                        width: 50.w,
                                        decoration:  BoxDecoration(
                                            color: ColorManager.greyColorCBCBCB,
                                            borderRadius: BorderRadius.circular(15.h)
                                          // shape: BoxShape.circle
                                        ),
                                      ),),
                                    SizedBox(
                                      height: 8.h,
                                    ) ,
                                    const Spacer(),
                                    CustomButton(
                                      onTap: () {
                                        NavigationService.push(
                                            context, Routes.latestNewCarsDetails  ,
                                            arguments: {
                                              "isShowRoom" : true ,
                                              "carModel" : data.carList[index]
                                            }
                                        );
                                      },
                                      buttonText:  translate(LocaleKeys.details),
                                      backgroundColor: ColorManager.primaryColor,
                                      height: 40.h,
                                    )
                                  ]),
                            ),
                          ) ,


                        ],
                      ),
                    ),
                  ),
                  shared!.getString("role") =="showroom"||
                      shared!.getString("role") == "agency" ?  const SizedBox(): Align(
                    alignment: Alignment.topLeft,
                    child:  Consumer<FavViewModel>(builder: (_,data1 , __){
                      return  SizedBox(
                        width: 260.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TapEffect(
                                onClick: ()async{
                                  await data1.addRemoveFav(context: context,
                                      carId: data.carList[index].id! ,
                                      car: data.carList[index]) ;
                                },
                                child:  Container(
                                  padding: EdgeInsets.all(8.h),
                                  decoration: const BoxDecoration(
                                    color: ColorManager.white ,
                                    shape: BoxShape.circle
                                  ),
                                  child: Icon(
                                    data1.showFavCarsResponse != null  ?
                                    data1.showFavCarsResponse!.data!.any((element)
                                    => element.id ==
                                        data.carList[index].id) ?
                                    Icons.favorite : Icons.favorite_border_outlined : Icons.favorite_border_outlined,
                                    color: ColorManager.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) ;
                    }),
                  ),

                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const HorizontalSpace(2);
            },
          ) ;
        },
      ),
    );
  }
}
