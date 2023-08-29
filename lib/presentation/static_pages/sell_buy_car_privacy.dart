import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/presentation/static_pages/view_model.dart';
import 'package:flutter/material.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:provider/provider.dart';

import '../component/custom_text.dart';

class SellBuyPrivacy extends StatelessWidget {
  const SellBuyPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final staticPageProvider = Provider.of<StaticPagViewModel>(context , listen: false) ;
    staticPageProvider.returnCar(context: context) ;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child:  MyAppbar(
          title: translate(LocaleKeys.carReturn),
          centerTitle: true,
          titleColor: ColorManager.white,
          backgroundColor: ColorManager.primaryColor,
          leading: TapEffect(
              onClick: () {
                NavigationService.goBack(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.white,
              )),
        ),
      ),
      body: Column(
        children:  [
          Consumer<StaticPagViewModel>(builder: (_ , data , __){
            if(data.isLoading){
              return const Center(
                child: CircularProgressIndicator(),
              ) ;
            }else{

              return Text("${data.showReturnCarResponse?.data?.description}");
            }
          })
        ],
      ),
    );
  }
}
