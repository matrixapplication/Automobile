import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/resources/app_values.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/presentation/track_ur_request/view_model/track_ur_request_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TrackUrRequest extends StatefulWidget {
  const TrackUrRequest({Key? key}) : super(key: key);

  @override
  State<TrackUrRequest> createState() => _TrackUrRequestState();
}

class _TrackUrRequestState extends State<TrackUrRequest> {
  final _key = GlobalKey<FormState>() ; 
  final TextEditingController controller = TextEditingController() ;
  Future<void> _submit(context, TrackYourRequestViewModel viewModel) async {
    if (kDebugMode) {
      ResponseModel responseModel = await viewModel.trackUrRequest(context: context, phone: "0128292929");
      if (responseModel.isSuccess) {
        //NavigationService.pushReplacement(context, Routes.homeScreen);

        // NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
      }
    } else {
      FocusScope.of(context).unfocus();
      if (!_key.currentState!.validate()) {
        debugPrint("Form Not Valid");
        return;
      }
      _key.currentState!.save();
      ResponseModel responseModel = await viewModel.trackUrRequest(
          context: context,
          phone: controller.text);

      if (responseModel.isSuccess) {

      }else{
        showCustomSnackBar(message: responseModel.message.toString(), context: context) ;
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final trackProvider = Provider.of<TrackYourRequestViewModel>(context , listen: false) ;
    trackProvider.clearData() ;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose()  ;

  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child:  MyAppbar(
          title: translate(LocaleKeys.trackUrRequest),
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
      body: SizedBox(
        width: deviceWidth,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.h),

          child: Consumer<TrackYourRequestViewModel>(
            builder: (_ , viewModel ,__){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ) ,
                  Image.asset("assets/images/on_boarding.png" , height: 300.h,) ,
                  Text(translate(LocaleKeys.trackUrRequestMessage) , style: Theme.of(context).textTheme.labelLarge,) ,
                  SizedBox(
                    height: 15.h,
                  ) ,
                  Form(
                    key: _key,
                    child: CustomTextField(

                      controller: controller,
                      borderRadius: 15.r,
                      prefixIcon: const Icon(Icons.message , color:  ColorManager.primaryColor,),
                      isValidator: true,
                      validate: (value){
                        if(value == null || value.isEmpty){
                          return translate(LocaleKeys.required) ;
                        }
                        return"" ;
                      },
                      isPhoneNumber: true,
                      contentVerticalPadding: 17.h,
                      borderColor: ColorManager.canvasColorFBFBFB,
                      textInputType: TextInputType.phone,

                    ),
                  ) ,
                  SizedBox(
                    height: 15.h,
                  ) ,
                  !viewModel.isLoading ?  CustomButton(
                    height: 60.h,
                    borderColor: ColorManager.primaryColor,
                    backgroundColor: ColorManager.primaryColor,
                    buttonText: translate(LocaleKeys.ok),
                    textColor: ColorManager.white,
                    onTap: (){
                      _submit(context, viewModel) ;
                    },
                  ) : MyProgressIndicator() ,
                  SizedBox(
                    height: 15.h,
                  ) ,


                  viewModel.response != null ?
                  Container(
                    width: 400.w,
                    padding: EdgeInsets.all(15.h),
                    decoration: BoxDecoration(
                      color: ColorManager.greyCanvasColor ,
                      borderRadius: BorderRadius.circular(15.h)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Name: ${viewModel.response?.name}"  , textStyle: Theme.of(context).textTheme.labelLarge,) ,
                        SizedBox(
                          height:  10.h,
                        ) ,
                        CustomText(text: "Phone: ${viewModel.response?.phone}" , textStyle: Theme.of(context).textTheme.labelLarge,) ,
                        SizedBox(
                          height:  10.h,
                        ) ,
                        CustomText(text: "Statue: ${viewModel.response?.isApproved}", textStyle: Theme.of(context).textTheme.labelLarge, ) ,
                      ],
                    ),
                  ) :
                      const SizedBox()

                ],
              ) ;
            },
          ),
        ),
      ),
    );
  }
}
