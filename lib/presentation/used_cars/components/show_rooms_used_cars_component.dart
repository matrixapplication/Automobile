import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/components.dart';
import '../../component/custom_button.dart';
import '../../component/cutom_shimmer_image.dart';

class ShowRoomsCarsGridComponent extends StatefulWidget {
  const ShowRoomsCarsGridComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowRoomsCarsGridComponent> createState() => _ShowRoomsCarsGridComponentState();
}

class _ShowRoomsCarsGridComponentState extends State<ShowRoomsCarsGridComponent> {

  final _controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;
    final newCarsAgencyProvider = Provider.of<UsedCarsShowRoomViewModel>(context , listen : false) ;


      Provider.of<UsedCarsShowRoomViewModel>(context, listen: false)
          .getMyCars(
          context: context,
          id: null,
          modelRole: "showroom",
          states :"used" ,
          isAll: true
      )  ;


    _controller.addListener(() {
      // if reach to end of the list\
      if (_controller.position.maxScrollExtent == _controller.offset) {
        // fetch();
        Provider.of<UsedCarsShowRoomViewModel>(context, listen: false)
            .getMyCars(
            context: context,
            id: null,
            modelRole: "showroom",
            states :"used" ,
            isAll: false
        ) ;
        print("Fetch");
      } else {
        print("Not Fetch");
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    final userFavProvider = Provider.of<FavViewModel>(context , listen:  true) ;

    return Consumer<UsedCarsShowRoomViewModel>(builder: (_ , data , __){
      return GridView.builder(
          controller: _controller,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // padding: EdgeInsets.symmetric(horizontal: 7.w),
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.23,
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: data.shocarList.length,
          itemBuilder: (ctx, index) => Container(
            // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.greyColorCBCBCB)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    TapEffect(onClick: (){
                      NavigationService.push(
                          context, Routes.usedCarDetailsPage,
                          arguments: {"isShowRoom": true , "carModel" : data.shocarList[index]});
                    }, child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CustomShimmerImage(
                          image:
                          "${data.shocarList[index].mainImage}",
                          boxFit: BoxFit.cover,
                          height: 150.h,
                          width: double.infinity,
                        ),
                      ),
                    )),


                    shared?.getString("role") == "showroom" || shared?.getString("role")== "agency"?
                    const SizedBox() :
                    shared!.getString("role") =="showroom"||
                        shared!.getString("role") == "agency" ?  const SizedBox():Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 6.h,
                            ) ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TapEffect(
                                  onClick: ()async{
                                    final favProvider = Provider.of<FavViewModel>(context , listen: false) ;
                                    await favProvider.addRemoveFav(context: context,
                                        carId: data.shocarList[index].id! ,
                                        car: data.shocarList[index]) ;

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
                                        userFavProvider.showFavCarsResponse != null ?
                                        userFavProvider.showFavCarsResponse!.data!.any((element) => element.id == data.shocarList[index].id) ?
                                        Icons.favorite : Icons.favorite_border_outlined : Icons.favorite_border_outlined,
                                        color: ColorManager.primaryColor,
                                      ) ,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    ) ,
                    data.shocarList[index].isBayed! ?
                    Align(
                      alignment: shared!.getString("lang") == "en" ? Alignment.topLeft : Alignment.topRight,
                      child: Container(
                        width: 90.w,
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor ,
                          borderRadius: BorderRadius.only(
                              topLeft:  shared!.getString("lang") == "en" ? Radius.circular(12.r) : Radius.circular(0),

                              topRight:   shared!.getString("lang") == "ar" ? Radius.circular(12.r) :  Radius.circular(0)
                          ) ,
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
                ) ,
                SizedBox(
                  height: 20.h,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:data.shocarList[index].brand?.name  != null ?
                      CustomText(
                          text: "${data.shocarList[index].brand?.name} ${data.shocarList[index].brandModel?.name} ${data.shocarList[index].year}",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                              height: 1.2,
                              color: ColorManager.blackColor1C1C1C,
                              fontWeight: FontWeightManager.semiBold)) :
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[600]!,
                        child: Container(
                          height: 14.h,
                          width: 20.w,
                          decoration:  BoxDecoration(
                              color: ColorManager.greyColorCBCBCB,
                              borderRadius: BorderRadius.circular(15.h)

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

                data.shocarList[index].price != null ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "${double.parse("${data.shocarList[index].price}").toStringAsFixed(0)} ${translate(LocaleKeys.egp)}",
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                            color: ColorManager.primaryColor,
                            fontWeight: FontWeightManager.semiBold,
                            height: 1))
                  ],
                ): Shimmer.fromColors(
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
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: CustomButton(
                    buttonText: translate(LocaleKeys.details),
                    backgroundColor: ColorManager.primaryColor,
                    height: 40.h,
                    onTap: () {
                      NavigationService.push(
                          context, Routes.usedCarDetailsPage,
                          arguments: {"isShowRoom": true , "carModel" : data.shocarList[index]});
                    },
                  ),
                )
              ],
            ),
          )) ;
    });
  }
}