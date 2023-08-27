import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/resources/resources.dart';
import '../../component/components.dart';

class CarShowRoomsBranchesComponent extends StatefulWidget {
  final int id ;
  const CarShowRoomsBranchesComponent({
    Key? key, required this.id,
  }) : super(key: key);

  @override
  State<CarShowRoomsBranchesComponent> createState() => _CarShowRoomsBranchesComponentState();
}

class _CarShowRoomsBranchesComponentState extends State<CarShowRoomsBranchesComponent> {
  String? _selectedArea;

  List<String> areas = ["Cairo", "Giza", "Alexandria", "Qena"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0) , ()async{
      final brachesProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: false) ;
      await brachesProvider.getBranchesById(context: context, id: widget.id) ;
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
    final brachesProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: true) ;
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // //SelectArea
        // Container(
        //   height: 50.h,
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   margin: EdgeInsets.symmetric(horizontal: 10.w),
        //   width: deviceWidth*0.50,
        //   decoration: BoxDecoration(
        //     color: ColorManager.white,
        //     border: Border.all(color: ColorManager.primaryColor),
        //     borderRadius: BorderRadius.circular(
        //       RadiusManager.s16.r,
        //     ),
        //   ),
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.location_on_rounded,
        //         color: ColorManager.primaryColor,
        //         size: 30.w,
        //       ),
        //       Expanded(
        //         child: DropdownButton(
        //           value: _selectedArea,
        //           focusColor: Colors.yellow,
        //           iconEnabledColor: Colors.red,
        //           //itemHeight: 55.0,
        //           isExpanded: true,
        //           //value: dropdownValue,
        //           icon: const Icon(
        //             Icons.keyboard_arrow_down,
        //             color: ColorManager.primaryColor,
        //           ),
        //           iconSize: 30,
        //           //style: Theme.of(context).textTheme.headline5,
        //           hint: CustomText(
        //             text: "All Regions",
        //             textStyle: Theme.of(context)
        //                 .textTheme
        //                 .titleMedium!
        //                 .copyWith(color: ColorManager.greyColor919191),
        //           ),
        //           onChanged: (newValue) {
        //             setState(() {
        //               _selectedArea = newValue.toString();
        //               debugPrint("_selected Group Id $newValue");
        //             });
        //           },
        //           underline: Container(
        //             height: 2,
        //             color: Colors.transparent,
        //           ),
        //           items: areas
        //               .map<DropdownMenuItem<String>>((String value) {
        //             return DropdownMenuItem<String>(
        //               //for make on change Return id
        //               value: value.toString(),
        //               child: CustomText(
        //                   text: value,
        //                   textStyle: Theme.of(context)
        //                       .textTheme
        //                       .labelMedium!
        //                       .copyWith(color: ColorManager.black)),
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        !brachesProvider.isLoading ?
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: brachesProvider.branchList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.w, horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "${brachesProvider.branchList[index].district}",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                            color: ColorManager
                                .blackColor1C1C1C,
                            height: 1,
                            fontSize: FontSize.s20.sp,
                            fontWeight:
                            FontWeightManager.semiBold,
                          )),
                      const VerticalSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                                text:
                                "${brachesProvider.branchList[index].name}",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                  color: ColorManager
                                      .blackColor1C1C1C,
                                  height: 1,
                                  fontWeight:
                                  FontWeightManager
                                      .medium,
                                )),
                          ),
                          const HorizontalSpace(15),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15.r),
                                border: Border.all(
                                    color: ColorManager
                                        .greyColorCBCBCB)),
                            child: Center(
                              child: CustomText(
                                  text: "${brachesProvider.branchList[index].city}",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    color: ColorManager
                                        .greyColor515151,
                                    height: 1,
                                    fontWeight:
                                    FontWeightManager
                                        .medium,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpace(35),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(15.r),
                          color: ColorManager.greyColorCBCBCB
                              .withOpacity(0.4),
                        ),
                        padding:
                        EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: TapEffect(
                                  onClick: () {
                                    if(userProvider.isAuth){
                                      telePhone(brachesProvider.branchList[index].phone.toString()) ;
                                    }else{
                                      showCustomSnackBar(message: "please login first", context: context) ;
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      const Icon(Icons.call,
                                          color: ColorManager
                                              .primaryColor),
                                      HorizontalSpace(10.w),
                                      CustomText(
                                        text: "Call",
                                        textStyle: Theme.of(
                                            context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                            fontWeight:
                                            FontWeightManager
                                                .semiBold,
                                            color:
                                            ColorManager
                                                .black),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              width: 1,
                              height: 35.h,
                              color:
                              ColorManager.greyColor919191,
                            ),
                            Expanded(
                              child: TapEffect(
                                  onClick: () {
                                    if(userProvider.isAuth){
                                      launchWhatsAppUri(brachesProvider.branchList[index].whatsapp!);
                                    }else{
                                      showCustomSnackBar(message: "please login first", context: context) ;
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      const Icon(
                                          Icons.message,
                                          color: ColorManager
                                              .primaryColor),
                                      HorizontalSpace(10.w),
                                      CustomText(
                                        text: "What's app",
                                        textStyle: Theme.of(
                                            context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                            fontWeight:
                                            FontWeightManager
                                                .semiBold,
                                            color:
                                            ColorManager
                                                .black),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder:
                (BuildContext context, int index) {
              return const VerticalSpace(10);
            },
          ),
        ) : const Center(child: MyProgressIndicator()),
      ],
    );
  }
}