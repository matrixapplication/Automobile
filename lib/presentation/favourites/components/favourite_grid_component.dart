import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/components.dart';
import '../../component/custom_button.dart';
import '../../component/cutom_shimmer_image.dart';

class FavouriteGridComponent extends StatefulWidget {
  const FavouriteGridComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriteGridComponent> createState() => _FavouriteGridComponentState();
}

class _FavouriteGridComponentState extends State<FavouriteGridComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Future.delayed(const Duration(seconds: 0) , () async {

        if (mounted) {
          final favProvider = Provider.of<FavViewModel>(context , listen: false) ;
          await favProvider.getMyCars(context: context) ;
        }

      },) ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userFavProvider = Provider.of<FavViewModel>(context , listen: true) ;
    //Future<ResponseModel<List<CarModel>>>
    return Consumer<FavViewModel>(
      builder: (_ , data , __){
        return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.45,
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 5.h,
            ),
            padding: EdgeInsets.only(top: 10.h),
            itemCount: data.showFavCarsResponse?.data?.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.symmetric(
                  vertical: 10.h, horizontal: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: ColorManager.greyColorCBCBCB)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: CustomShimmerImage(
                            image:
                            "${data.showFavCarsResponse?.data?[index].mainImage}",
                            boxFit: BoxFit.cover,
                            height: 150.h,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child:     Consumer<FavViewModel>(builder: (_,data , __){
                          return  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TapEffect(
                                onClick: ()async{
                                  await data.addRemoveFav(context: context,
                                      carId: data.showFavCarsResponse!.data![index].id! ,
                                      car: data.showFavCarsResponse!.data![index]) ;

                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.h),
                                  margin: EdgeInsets.symmetric(horizontal: 8.w , vertical: 6.h),
                                  decoration: const BoxDecoration(
                                      color: Colors.white ,
                                      shape: BoxShape.circle
                                  ),
                                  child:  Center(
                                    child: Icon(
                                      data.showFavCarsResponse!.data!.any((element)
                                      => element.id ==
                                          data.showFavCarsResponse?.data?[index].id) ?
                                      Icons.favorite : Icons.favorite_border_outlined,
                                      color: ColorManager.primaryColor,
                                    ) ,
                                  ),
                                ),
                              ),
                            ],
                          ) ;
                        }),
                      ) ,
                      data.showFavCarsResponse!.data![index].isBayed! ?
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 90.w,
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor ,
                            borderRadius: BorderRadius.circular(15.r) ,
                          ),
                          child: Center(
                            child: CustomText(text: translate(LocaleKeys.soldOut)  , textStyle: Theme.of(context)
                                .textTheme.bodySmall!.copyWith(
                                color: ColorManager.white
                            ),) ,
                          ),
                        ),
                      ) : const SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "${data.showFavCarsResponse?.data?[index].brand?.name} ${data.showFavCarsResponse?.data?[index].brandModel?.name} ${data.showFavCarsResponse?.data?[index].brandModelExtension?.name}",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                              color: ColorManager
                                  .blackColor1C1C1C,
                              height: 1,
                              fontWeight: FontWeightManager
                                  .semiBold) ,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "${data.showFavCarsResponse!.data![index].price!} EGP",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                              color: ColorManager.primaryColor,
                              fontWeight:
                              FontWeightManager.semiBold,
                              fontSize: FontSize.s22,
                              height: 1)),
                    ],
                  ),

                  const Spacer(),
                  CustomButton(
                    buttonText: translate(LocaleKeys.details),
                    backgroundColor: ColorManager.primaryColor,
                    height: 40.h,
                    onTap: () {
                      NavigationService.push(
                          context, Routes.usedCarDetailsPage , arguments: {
                            "carModel" : data.showFavCarsResponse?.data?[index] ,
                            "isShowRoom" : data.showFavCarsResponse?.data?[index].modelObject!.name == "showroom" ||
                                data.showFavCarsResponse?.data?[index].modelObject!.name =="agency"? true : false
                      });
                    },
                  )
                ],
              ),
            ));

      },
    );
  }
}