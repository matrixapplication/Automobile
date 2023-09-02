import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../bottom_navigation_bar/pages/home/view_model/show_room_view_model.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/components.dart';
import '../../component/cutom_shimmer_image.dart';

class CarShowRoomPage extends StatefulWidget {
  const CarShowRoomPage({Key? key}) : super(key: key);

  @override
  State<CarShowRoomPage> createState() => _CarShowRoomPageState();
}

class _CarShowRoomPageState extends State<CarShowRoomPage> {
  final _controller = ScrollController();
  bool reveal = false ; 
  @override
  void initState() {
    Provider.of<ShowRoomsViewModel>(context, listen: false)
        .getShowRooms(context: context, isClear: true);
    _controller.addListener(() {
      // if reach to end of the list
      if (_controller.position.maxScrollExtent == _controller.offset) {
        // fetch();
        Provider.of<ShowRoomsViewModel>(context, listen: false).getShowRooms(context: context , isClear: false);
        if (kDebugMode) {
          print("Fetch");
        }
      } else {
        if (kDebugMode) {
          print("Not Fetch");
        }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  telePhone(String phone) async {
    // The "launch" method is part of "url_launcher".
    await launchUrl(Uri.parse('tel://+20$phone'),
        mode: LaunchMode.externalApplication);
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context,listen: false) ;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.showRooms),
        titleColor: ColorManager.white,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child:  Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.white,
              textDirection: shared!.getString("lang") == "ar" ? TextDirection.ltr : TextDirection.rtl,
            )),
      )),
      body: Consumer<ShowRoomsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: MyProgressIndicator());
          } else if (viewModel.showRoomsList.isEmpty) {
            return  CustomText(
              text: translate(LocaleKeys.dataNotFound),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: ListView.separated(
                controller: _controller,
                physics: const BouncingScrollPhysics(),


                itemCount: viewModel.showRoomsList.length+1,
                itemBuilder: (context, index) {

                  if (index < viewModel.showRoomsList.length) {
                    final item = viewModel.showRoomsList[index];

                    return !item.isBlocked!  ?
                    TapEffect(
                      onClick: () {
                        NavigationService.push(context,
                            Routes.carShowRoomProfilePage , arguments: {
                              "showRoomModel" : viewModel.showRoomsList[index] ,
                              "tab" : 0
                            });
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.w, horizontal: 10.w),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: CustomShimmerImage(
                                    image:
                                    "${viewModel.showRoomsList[index].image}",
                                    boxFit: BoxFit.contain,
                                    height: 100.h,
                                    width: 120.h,
                                  ),
                                ),
                                HorizontalSpace(20.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: item.showroomName,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                            color:
                                            ColorManager.blackColor1C1C1C,
                                            height: 1,
                                            fontWeight:
                                            FontWeightManager.semiBold,
                                          )),
                                      const VerticalSpace(15),
                                      DescriptionText(text: item.description!, reveal: reveal)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const VerticalSpace(20),
                            Container(
                              color:
                              ColorManager.greyColorCBCBCB.withOpacity(0.4),
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TapEffect(
                                        onClick: () {
                                          if(userProvider.isAuth){
                                            telePhone(item.phone!);
                                          }else{
                                            showCustomSnackBar(message: "please login first", context: context);
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.call,
                                                color: ColorManager.primaryColor),
                                            HorizontalSpace(10.w),
                                            CustomText(
                                              text: "Call",
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeightManager
                                                      .semiBold,
                                                  color: ColorManager.black),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 35.h,
                                    color: ColorManager.greyColor919191,
                                  ),
                                  Expanded(
                                    child: TapEffect(
                                        onClick: () {
                                          NavigationService.push(context,
                                              Routes.carShowRoomProfilePage , arguments: {
                                                "showRoomModel" : viewModel.showRoomsList[index] ,
                                                "tab" : 2
                                              });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.location_on,
                                                color: ColorManager.primaryColor),
                                            HorizontalSpace(10.w),
                                            CustomText(
                                              text: translate(LocaleKeys.branches),
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeightManager
                                                      .semiBold,
                                                  color: ColorManager.black),
                                            )
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ) : const SizedBox();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Center(
                        child: viewModel.hasMore
                            ?  const MyProgressIndicator()
                            : const SizedBox(),
                      ),
                    );
                  }





                },
                separatorBuilder: (BuildContext context, int index) {
                  return const VerticalSpace(10);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
class DescriptionText extends StatefulWidget {
  final String text ;
  final bool reveal ;
  const DescriptionText({Key? key, required this.text, required this.reveal}) : super(key: key);

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {

  bool view  = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view = widget.reveal ;

  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            widget.text,
            maxLines: !view ? 1 : null,
            overflow: !view ? TextOverflow.ellipsis : null,
          ),

          TapEffect(onClick: (){
            setState(() {
              view = !view;
            });
          }, child: Text(view  ?  translate(LocaleKeys.less): translate(LocaleKeys.more) , style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.blueAccent ,
              fontSize: 14.h
          ),))
        ],
      ),
    );
  }
}