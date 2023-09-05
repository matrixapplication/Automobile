    import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';
import '../../../../component/cutom_shimmer_image.dart';

class HomeTopUsedCarsComponent extends StatefulWidget {
  const HomeTopUsedCarsComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTopUsedCarsComponent> createState() => _HomeTopUsedCarsComponentState();
}

class _HomeTopUsedCarsComponentState extends State<HomeTopUsedCarsComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UsedCarsShowRoomViewModel>(context , listen: false).
    getMyCars(context: context, id: null, modelRole: null, states: "used" ,isAll: true);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310.h,
      child: Consumer<UsedCarsShowRoomViewModel>(
        builder: (_ , data , __){
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.carList.isNotEmpty ? data.carList.length < 6 ? data.carList.length: 6 : 0 ,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              return Container(
                height: 310.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: deviceWidth * 0.60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: ColorManager.greyColorCBCBCB)
                ),
                child: ClipRRect(

                  borderRadius: BorderRadius.circular(12.r),

                  child: Stack(
                    children: [
                      /*
                          NavigationService.push(
                                        context, Routes.usedCarDetailsPage ,
                                        arguments: {
                                          "isShowRoom" : data.carList[index].modelRole =="showroom"? true : false ,
                                          "carModel" : data.carList[index]
                                        }
                                    );*/
                      TapEffect(onClick: (){
                        NavigationService.push(
                            context, Routes.usedCarDetailsPage ,
                            arguments: {
                              "isShowRoom" : data.carList[index].modelRole =="showroom"? true : false ,
                              "carModel" : data.carList[index]
                            }
                        );
                      }, child: Padding(
                        padding: EdgeInsets.only(bottom: 115.h , top:  10.h , right: 10.h ,  left: 10.h),
                        child:  CustomShimmerImage(
                          image:
                          "${data.carList[index].mainImage}",
                          boxFit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )),
                      data.carList[index].isBayed! ?
                      Align(
                        alignment: shared!.getString("lang") == "en" ? Alignment.topLeft : Alignment.topRight,
                        child: Container(
                          width: 90.w,
                          height: 40.h,
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor ,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.r)
                            ) ,
                          ),
                          child: Center(
                            child: CustomText(text: translate(LocaleKeys.soldOut)  , textStyle: Theme.of(context)
                                .textTheme.bodySmall!.copyWith(
                                color: ColorManager.white
                            ),) ,
                          ),
                        ),
                      ) : const SizedBox() ,
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
                                  color: ColorManager.greyColorCBCBCB.withOpacity(0.1) ,
                                  blurRadius: 48 ,
                                  spreadRadius: 6 ,
                                  offset:  const Offset(0, 0)
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
                                        .titleMedium!
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
                                )  ,


                                data.carList[index].price != null ?  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: "${double.parse("${data.carList[index].price}").toStringAsFixed(0)} ${translate(LocaleKeys.egp)}",
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
                                )  ,
                                const Spacer(),
                                CustomButton(
                                  onTap: () {
                                    NavigationService.push(
                                        context, Routes.usedCarDetailsPage ,
                                        arguments: {
                                          "isShowRoom" : data.carList[index].modelRole =="showroom"? true : false ,
                                          "carModel" : data.carList[index]
                                        }
                                    );
                                  },
                                  buttonText: translate(LocaleKeys.details),
                                  backgroundColor: ColorManager.primaryColor,
                                  height: 40.h,
                                )
                              ]),
                        ),
                      ) ,
                      shared!.getString("role") =="showroom"||
                          shared!.getString("role") == "agency" ?  const SizedBox(): Align(
                        alignment: Alignment.topLeft,
                        child: Consumer<FavViewModel>(builder: (_,data1 , __){
                          return  SizedBox(
                            width: 260.w,
                            child: Padding(
                              padding:  EdgeInsets.all(8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TapEffect(
                                    onClick: ()async{
                                      await data1.addRemoveFav(context: context,
                                          carId: data.carList[index].id! ,
                                          car: data.carList[index]) ;

                                    },
                                    child: Container(

                                      padding:  EdgeInsets.all(8.h),
                                      decoration : const BoxDecoration(
                                        color: ColorManager.white ,
                                        shape: BoxShape.circle
                                      ),
                                      child: Icon(
                                        data1.showFavCarsResponse != null ?
                                        data1.showFavCarsResponse!.data!.any((element)
                                        => element.id ==
                                            data.carList[index].id) ?
                                        Icons.favorite : Icons.favorite_border_outlined: Icons.favorite_border_outlined ,
                                        color: ColorManager.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) ;
                        }),
                      ),
                    ],
                  ),
                ),
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
