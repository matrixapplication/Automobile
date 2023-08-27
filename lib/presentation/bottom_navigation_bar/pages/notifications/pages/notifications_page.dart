import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/app_widgets/my_app_bar.dart';
import '../../../../component/components.dart';
import '../../../../component/cutom_shimmer_image.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: MyAppbar(
        title: "Notifications",
        centerTitle: true,
/*        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.black,
            )),*/
      ), preferredSize: Size.fromHeight(70.h)),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return TapEffect(
              onClick: () {
                // NavigationService.push(context, Routes.carShowRoomDetailsPage);
              },
              child: Card(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CustomShimmerImage(
                          image:
                              "https://images.unsplash.com/photo-1594291465196-779b31a41c1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
                          boxFit: BoxFit.cover,
                          height: 120.h,
                          width: 150.h,
                        ),
                      ),
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
                                    text: "Sell Your Car In Egypt. Fast",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: ColorManager.blackColor1C1C1C,
                                          height: 1,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const HorizontalSpace(10),
                                CustomText(
                                  text: "5 days ago",
                                  textStyle:Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                    color: ColorManager.greyColor919191,
                                    height: 1,
                                    fontWeight: FontWeightManager.light,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ],
                            ),
                            const VerticalSpace(10),
                            CustomText(
                              text:
                                  '''Free & Just in One minute Choose your car 
information → Upload you car images → Get
 interested calls instantly''',
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
        ),
      ),
    );
  }
}
