import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/presentation/guarantee_cars/view_model/admin_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/components.dart';
import '../../component/custom_button.dart';
import '../../component/cutom_shimmer_image.dart';

class GuaranteeCarsComponent extends StatefulWidget {
  const GuaranteeCarsComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<GuaranteeCarsComponent> createState() => _GuaranteeCarsComponentState();
}

class _GuaranteeCarsComponentState extends State<GuaranteeCarsComponent> {
  final _controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AdminViewModel>(context, listen: false)
        .getAdminCars(context: context, isClear: true);
    _controller.addListener(() {
      // if reach to end of the list
      if (_controller.position.maxScrollExtent == _controller.offset) {
        // fetch();
        Provider.of<AdminViewModel>(context, listen: false)
            .getAdminCars(context: context);
        print("Fetch");
      } else {
        print("Not Fetch");
      }
    });
  }
  launchWhatsAppUri(String phone) async {
    // The "launch" method is part of "url_launcher".
    await launchUrl(Uri.parse('https://wa.me/phone=+2$phone?text=is your car available?'),
        mode: LaunchMode.externalApplication);
  }


  telePhone(String phone) async {
    // The "launch" method is part of "url_launcher".
    await launchUrl(Uri.parse('tel://+20$phone'),
        mode: LaunchMode.externalApplication);
  }
  @override
  Widget build(BuildContext context) {
    final userFavProvider = Provider.of<FavViewModel>(context , listen: true) ;

    return Consumer<AdminViewModel>(
      builder: (_ , data , __){

      if (data.isLoading) {
        return const Center(child: MyProgressIndicator());
      } else if (data.adminCarsList.isEmpty) {
        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
             CustomText(
              text: "No Data found",
            ),
          ],
        );
      } else {
        return GridView.builder(
            controller: _controller,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.40,
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemCount: data.adminCarsList.length,
            itemBuilder: (ctx, index){
              if(index < data.adminCarsList.length){
                return  Container(
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
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: TapEffect(
                              onClick: (){
                                NavigationService.push(
                                    context, Routes.guaranteeCarDetailsData ,
                                    arguments: {
                                      "adminCars" : data.adminCarsList[index]
                                    }

                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CustomShimmerImage(
                                  image:
                                  "${data.adminCarsList[index].mainImage}",
                                  boxFit: BoxFit.cover,
                                  height: 150.h,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          data.adminCarsList[index].isBayed! ?
                          Align(
                            alignment: shared!.getString("lang") == "en" ? Alignment.topLeft : Alignment.topRight,

                            child: Container(
                              width: 90.w,
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
                          ) : const SizedBox() ,



                          shared!.getString("role") =="showroom"||
                              shared!.getString("role") == "agency" ?  const SizedBox():          Align(
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
                                              carId: data.adminCarsList[index].id! ,
                                              car: CarModel.fromJson(data.adminCarsList[index].toJson())) ;

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
                                              userFavProvider.showFavCarsResponse!.data!.any((element) => element.id == data.adminCarsList[index].id) ?
                                              Icons.favorite : Icons.favorite_border_outlined :Icons.favorite_border_outlined,
                                              color: ColorManager.primaryColor,
                                            ) ,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomText(
                                text: "${data.adminCarsList[index].brand?.name} ${data.adminCarsList[index].brandModel?.name} ${data.adminCarsList[index].brandModelExtension?.name}",
                                textStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                    height: 1.2,
                                    color: ColorManager
                                        .blackColor1C1C1C,

                                    fontWeight: FontWeightManager
                                        .semiBold)),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "${data.adminCarsList[index].price} ${translate(LocaleKeys.egp)}",
                              textStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: ColorManager.primaryColor,
                                  fontWeight:
                                  FontWeightManager.semiBold,
                                  height: 1))
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        buttonText: translate(LocaleKeys.details),
                        backgroundColor: ColorManager.primaryColor,
                        height: 40.h,
                        onTap: () {
                          NavigationService.push(
                              context, Routes.guaranteeCarDetailsData ,
                              arguments: {
                                "adminCars" : data.adminCarsList[index]
                              }

                          );
                        },
                      )
                    ],
                  ),
                ) ;
              }else{
                return const  CustomText(text: "No More data") ;
              }
            }
               );
      }
      },
    );
  }
}