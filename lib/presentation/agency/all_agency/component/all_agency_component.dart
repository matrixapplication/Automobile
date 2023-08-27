import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../component/components.dart';

class CarShowRoomsBranchesComponent extends StatefulWidget {
  const CarShowRoomsBranchesComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<CarShowRoomsBranchesComponent> createState() =>
      _CarShowRoomsBranchesComponentState();
}

class _CarShowRoomsBranchesComponentState
    extends State<CarShowRoomsBranchesComponent> {
  String? _selectedArea;

  List<String> areas = ["Cairo", "Giza", "Alexandria", "Qena"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SelectArea
        Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          width: deviceWidth * 0.50,
          decoration: BoxDecoration(
            color: ColorManager.white,
            border: Border.all(color: ColorManager.primaryColor),
            borderRadius: BorderRadius.circular(
              RadiusManager.s16.r,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: ColorManager.primaryColor,
                size: 30.w,
              ),
              Expanded(
                child: DropdownButton(
                  value: _selectedArea,
                  focusColor: Colors.yellow,
                  iconEnabledColor: Colors.red,
                  //itemHeight: 55.0,
                  isExpanded: true,
                  //value: dropdownValue,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorManager.primaryColor,
                  ),
                  iconSize: 30,
                  //style: Theme.of(context).textTheme.headline5,
                  hint: CustomText(
                    text: "All Regions",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ColorManager.greyColor919191),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedArea = newValue.toString();
                      debugPrint("_selected Group Id $newValue");
                    });
                  },
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  items: areas.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      //for make on change Return id
                      value: value.toString(),
                      child: CustomText(
                          text: value,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: ColorManager.black)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.w, horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Maadi",
                          textStyle:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: ColorManager.blackColor1C1C1C,
                                    height: 1,
                                    fontSize: FontSize.s20.sp,
                                    fontWeight: FontWeightManager.semiBold,
                                  )),
                      const VerticalSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                                text: "Smart Village - New Maadi",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: ColorManager.blackColor1C1C1C,
                                      height: 1,
                                      fontWeight: FontWeightManager.medium,
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
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                    color: ColorManager.greyColorCBCBCB)),
                            child: Center(
                              child: CustomText(
                                  text: "Cairo",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: ColorManager.greyColor515151,
                                        height: 1,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpace(35),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: ColorManager.greyColorCBCBCB.withOpacity(0.4),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: TapEffect(
                                  onClick: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                    FontWeightManager.semiBold,
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
                                  onClick: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: ColorManager.primaryColor),
                                      HorizontalSpace(10.w),
                                      CustomText(
                                        text: "Branches",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                                color: ColorManager.black),
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
            separatorBuilder: (BuildContext context, int index) {
              return const VerticalSpace(10);
            },
          ),
        ),
      ],
    );
  }
}
