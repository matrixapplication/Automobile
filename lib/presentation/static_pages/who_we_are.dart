import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/resources/app_values.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/presentation/static_pages/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WhoWeAre extends StatelessWidget {
  const WhoWeAre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final staticPageProvider = Provider.of<StaticPagViewModel>(context , listen: false) ;
    staticPageProvider.aboutUs(context: context) ;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child:  MyAppbar(
          title: "Who we are",
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
      body: Consumer<StaticPagViewModel>(builder: (_ , data , __){
        if(data.isLoading){
          return SizedBox(
            height: deviceHeight*0.8,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ) ;
        }else{
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                Text("${data.showAboutResponse?.data?.description}")
              ],
            ),
          );
        }
      }),
    );
  }
}
