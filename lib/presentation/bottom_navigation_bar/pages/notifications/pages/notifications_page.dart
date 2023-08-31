import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/notifications/view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/app_widgets/my_app_bar.dart';
import '../../../../component/components.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late ScrollController controller = ScrollController() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<AllNotificationViewModel>(context, listen: false)
        .allNotifications(context: context , clear: true);

    controller.addListener(() async{
      if (controller.position.maxScrollExtent == controller.offset) {
        // fetch();
        Provider.of<AllNotificationViewModel>(context, listen: false)
            .allNotifications(context: context , clear: false);
        if (kDebugMode) {
          print("Fetch");
        }
      } else {
        if (kDebugMode) {
          print("Not Fetch");
        }
      }
    }) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: MyAppbar(
            title: translate(LocaleKeys.notifications),
            titleColor: ColorManager.white,
            backgroundColor: ColorManager.primaryColor,
            centerTitle: true,
            leading: TapEffect(
                onClick: () {
                  NavigationService.push(context, Routes.bottomNavigationBar);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorManager.white,
                )),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Consumer<AllNotificationViewModel>(
          builder: (_, data, __) {
            if (data.isLoading) {
              return SizedBox(
                height: deviceHeight *0.8,
                child:  const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (data.notificationList.isEmpty) {
              return SizedBox(
                height: deviceHeight * 0.8,
                child: Center(
                  child: CustomText(text: translate(LocaleKeys.dataNotFound)),
                ),
              );
            } else {
              return ListView.separated(
                itemCount: data.notificationList.length,
                itemBuilder: (context, index) {
                  return TapEffect(
                    onClick: () async{
                      if (data.notificationList[index].type == 'general') {

                      }
                      if (data.notificationList[index].type == "approved_showroom_car") {
                        final showCarViewModel = Provider.of<ShowRoomSellCarViewModel>(context , listen: false);
                        final result  = await showCarViewModel.showCarDetails(context: context,   id: data.notificationList[index].carId!) ;
                        if (kDebugMode) {
                          print(result.isSuccess);
                        }
                        try{
                          if(result.isSuccess){
                            if(result.data?.status?.name =='new'){
                              NavigationService.navigationKey.currentState?.pushNamed(
                                  Routes.latestNewCarsDetails,
                                  arguments: {"carModel": result.data, "isShowRoom": true});
                            }else{
                              if( result.data?.modelRole == "showroom"){
                                NavigationService.navigationKey.currentState?.pushNamed(
                                    Routes.usedCarDetailsPage,
                                    arguments: {"carModel": result.data, "isShowRoom": true});
                              }else{
                                NavigationService.navigationKey.currentState?.pushNamed(
                                    Routes.usedCarDetailsPage,
                                    arguments: {"carModel": result.data, "isShowRoom": false});
                              }
                            }
                          }else{
                            NavigationService.navigationKey.currentState?.pushNamed(
                                Routes.usedCarDetailsPage,
                                arguments: {"carModel": result.data, "isShowRoom": false});
                          }
                        }catch(e){
                          if (kDebugMode) {
                            print(e);
                          }
                        }



                      } else {

                      }
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            HorizontalSpace(20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text: "${data.notificationList[index].title}",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color: ColorManager
                                                    .blackColor1C1C1C,
                                                height: 1,
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const HorizontalSpace(10),

                                    ],
                                  ),
                                  const VerticalSpace(10),
                                  CustomText(
                                    text:'${data.notificationList[index].message}',
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: ColorManager.greyColor919191,
                                          height: 1,
                                          fontWeight: FontWeightManager.light,
                                        ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const VerticalSpace(10);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
