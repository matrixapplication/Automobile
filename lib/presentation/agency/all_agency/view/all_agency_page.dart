import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/navigation/navigation.dart';
import '../../../../core/resources/resources.dart';
import '../../../component/app_widgets/my_app_bar.dart';
import '../../../component/components.dart';
import '../../../component/cutom_shimmer_image.dart';
import '../view_model/agency_view_model.dart';

class AllAgencyPage extends StatefulWidget {
  const AllAgencyPage({Key? key}) : super(key: key);

  @override
  State<AllAgencyPage> createState() => _AllAgencyPageState();
}

class _AllAgencyPageState extends State<AllAgencyPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    Provider.of<AgencyViewModel>(context, listen: false)
        .getAgency(context: context, isClear: true);
    _controller.addListener(() {
      // if reach to end of the list
      if (_controller.position.maxScrollExtent == _controller.offset) {
        // fetch();
        Provider.of<AgencyViewModel>(context, listen: false)
            .getAgency(context: context);
        print("Fetch");
      } else {
        print("Not Fetch");
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
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: "AllAgencies",
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,
        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.white,
            )),
      )),
      body: Consumer<AgencyViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: MyProgressIndicator());
          } else if (viewModel.allAgencyList.isEmpty) {
            return  CustomText(
              text: translate(LocaleKeys.dataNotFound),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: ListView.separated(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                itemCount: viewModel.allAgencyList.length + 1,
                itemBuilder: (context, index) {
                  if (index < viewModel.allAgencyList.length) {
                    final item = viewModel.allAgencyList[index];
                    return TapEffect(
                      onClick: () {
                        NavigationService.push(
                            context, Routes.agencyProfilePage ,
                            arguments: {
                              "showRoomModel" : viewModel.allAgencyList[index] ,
                              "tab" : 0
                            }
                        );
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
                                        "${item.image}",
                                    boxFit: BoxFit.contain,
                                    height: 100.h,
                                    width: 120.h,
                                  ),
                                ),
                                HorizontalSpace(20.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: item.showroomName,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: ColorManager
                                                    .blackColor1C1C1C,
                                                height: 1,
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                              )),
                                      const VerticalSpace(15),
                                      CustomText(
                                          text: item.description,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: ColorManager
                                                    .blackColor1C1C1C,

                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                              ))
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
                                            telePhone(viewModel.allAgencyList[index].phone!);
                                          }else{
                                            showCustomSnackBar(message: "please login first", context: context);
                                          }

                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.call,
                                                color:
                                                    ColorManager.primaryColor),
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
                                                      color:
                                                          ColorManager.black),
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
                                          NavigationService.push(
                                              context, Routes.agencyProfilePage ,
                                              arguments: {
                                                "showRoomModel" : viewModel.allAgencyList[index] ,
                                                "tab" : 1
                                              }
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.location_on,
                                                color:
                                                    ColorManager.primaryColor),
                                            HorizontalSpace(10.w),
                                            CustomText(
                                              text: "Branches",
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeightManager
                                                              .semiBold,
                                                      color:
                                                          ColorManager.black),
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
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Center(
                        child: viewModel.hasMore
                            ? const MyProgressIndicator()
                            : CustomText(
                            text: "no more agency...",
                            textStyle: Theme.of(context).textTheme.bodySmall),
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
