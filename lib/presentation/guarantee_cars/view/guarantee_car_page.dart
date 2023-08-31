import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/resources/resources.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import '../../bottom_navigation_bar/pages/home/components/home_brands_component.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../components/guarantee_cars_components.dart';

class GuaranteeCarPage extends StatefulWidget {
  const GuaranteeCarPage({Key? key}) : super(key: key);

  @override
  State<GuaranteeCarPage> createState() => _GuaranteeCarPageState();
}

class _GuaranteeCarPageState extends State<GuaranteeCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.guaranteCars),
        centerTitle: true,
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child:  Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.white,
              textDirection: shared!.getString("lang") == "en"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            )),
      )),
      body: Scaffold(
          body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(10),

            Card(
              color: ColorManager.white,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                height: 65.h,
                child: Row(
                  children: [
                    Expanded(
                        child: TapEffect(
                          onClick:(){
                            NavigationService.push(context, Routes.filterPage , arguments: {
                              "type"  : null
                            });
                          },
                          child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(Icons.sort, size: 30.h),
                          HorizontalSpace(10.w),
                          CustomText(
                            text: translate(LocaleKeys.filter),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(),
                          )
                      ],
                    ),
                        )),
                    Container(
                      width: 1.5.w,
                      color: ColorManager.greyColorD6D6D6,
                      height: 55.h,
                    ),
                    Expanded(
                        child: TapEffect(
                          onClick: (){
                            NavigationService.push(context, Routes.sortPage  , arguments:  {
                              "admin" : "admin"
                            })  ;
                          },
                          child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(Icons.filter_alt_sharp, size: 30.h),
                          HorizontalSpace(10.w),
                          CustomText(
                            text: translate(LocaleKeys.sortBy),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(),
                          )
                      ],
                    ),
                        )),
                  ],
                ),
              ),
            ),
            const VerticalSpace(15),
            //Popular Brand
            Card(
              color: ColorManager.white,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const HomeBrandsComponent(role: null, status: null),
              ),
            ),
            const Expanded(child: GuaranteeCarsComponent())
          ],
        ),
      )),
    );
  }
}
