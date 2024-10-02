import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/finance_car/finance_car_screen.dart';
import 'package:automobile_project/presentation/finance_car/view_model/finance_car_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/navigation/navigation_services.dart';
import '../../config/navigation/routes.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import '../../core/resources/spaces.dart';
import '../../core/utils/alerts.dart';
import '../../core/utils/app_dialog.dart';
import '../../data/models/base_response/response_model.dart';
import '../../data/models/finance_car_model.dart';
import '../../data/provider/local_auth_provider.dart';
import '../../main.dart';
import '../../translations/local_keys.g.dart';
import '../component/app_widgets/my_app_bar.dart';
import '../component/custom_button.dart';
import '../component/custom_text.dart';
import '../component/tap_effect.dart';

class FinanceScreen extends StatefulWidget{
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  List<FinanceCarModel>? financeCarList;
  final _key = GlobalKey<FormState>();

  Map<String, dynamic> formData = {
    "offer_id": null,
    "name": null,
    "phone": null,
    "salary": null,

  };
  Future<void> _submit(
      context,
      int? offerId,
        String? name,
        String? phone,
        String? salary,
      ) async
  {
    formData = {
      "offer_id": offerId,
      "name": name,
      "phone": phone,
      "salary": salary,
    };

    final financeCarProvider =
    Provider.of<FinanceCarViewModel>(context, listen: false);

      FocusScope.of(context).unfocus();
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
          ResponseModel responseModel = await financeCarProvider.financeAddOfferCar(
              context: context, formData: formData);
          if (responseModel.isSuccess) {
            NavigationService.goBack(context) ;
            showCustomSnackBar(
                message: "${responseModel.message}", context: context,isError: false);
            NavigationService.goBack(context) ;

          } else {
            showCustomSnackBar(
                message: "${responseModel.message}", context: context);
          }
        } else {


        }


    financeCarProvider.offLoading();
  }

  @override
  void initState() {
    Provider.of<FinanceCarViewModel>(context, listen: false).getFinanceCar(context).then((value){
      if(value != null){
        financeCarList = value;
        setState(() {

        });
      }
    });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: MyAppbar(
              title: translate(LocaleKeys.financeCar),
              titleColor: ColorManager.white,
              backgroundColor: ColorManager.primaryColor,
              centerTitle: true,
              leading: TapEffect(
                  onClick: () {
                    NavigationService.goBack(context);
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.white,
                    textDirection: shared!.getString("lang") == "ar"
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  )),
              // actions: [
              //  InkWell(
              //    onTap: (){
              //      NavigationService.push(context,  Routes.financeCarPage);
              //    },
              //    child:   Container(
              //      margin: EdgeInsets.symmetric(horizontal: 20.w),
              //      decoration: BoxDecoration(
              //        color: ColorManager.white,
              //        borderRadius: BorderRadius.circular(15.r),
              //      ),
              //      child: Icon(
              //        Icons.add,
              //      ),
              //    ),
              //  )
              // ],
            )),
        body:
      Center(
        child:   financeCarList != null ?
        financeCarList!.isEmpty?Text(translate(LocaleKeys.dataNotFound)):
        ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          itemCount: financeCarList!.length,
          itemBuilder: (context, index) {
            return
              Container(
              margin: EdgeInsets.symmetric(vertical: 5.h,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1) ,
                      offset: const Offset(0, 0) ,
                      spreadRadius: 6 ,
                      blurRadius: 48
                  )
                ],
              ),
              child:
              InkWell(
                onTap: (){
                 final userProvider = Provider.of<LocalAuthProvider>(context , listen: false);

                  TextEditingController nameController = TextEditingController(text:  userProvider.endUser?.name ?? '');
                  TextEditingController phoneController = TextEditingController(text:  userProvider.endUser?.phone ?? '');
                  TextEditingController salaryController = TextEditingController();
                  showDialog(context: context, builder: (context){
                    return   AlertDialog(
                      content:
                      Form(
                        key: _key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.info_outline, size: 50.h, color: ColorManager.primaryColor),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomText(
                                text: 'طلب العرض',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: ColorManager.black)),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 50.h,
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: ColorManager.black),
                                    fillColor: ColorManager.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name'; // Message when the field is empty
                                  }

                                  return null; // If validation passes
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 50.h,
                              child: TextFormField(
                                keyboardType: TextInputType.number, // To ensure numeric input

                                controller: phoneController,
                                decoration: InputDecoration(
                                    labelText: 'Phone',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: ColorManager.black),
                                    fillColor: ColorManager.white,
                                    filled: true,

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                        borderSide: const BorderSide(
                                            color: ColorManager.greyCanvasColor,
                                            width: 2))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number'; // Message when the field is empty
                                  }

                                  return null; // If validation passes
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 50.h,
                              child:
                              TextFormField(

                                controller: salaryController,
                                keyboardType: TextInputType.number, // To ensure numeric input
                                decoration: InputDecoration(
                                  labelText: 'Salary',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: ColorManager.black),
                                  fillColor: ColorManager.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: const BorderSide(
                                          color: ColorManager.greyCanvasColor, width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: const BorderSide(
                                          color: ColorManager.greyCanvasColor, width: 2)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: const BorderSide(
                                          color: ColorManager.greyCanvasColor, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: const BorderSide(
                                          color: ColorManager.greyCanvasColor, width: 2)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a salary'; // Message when the field is empty
                                  }
                                  final salary = double.tryParse(value);
                                  if (salary == null || salary <= 0) {
                                    return 'Please enter a valid salary amount'; // Message for invalid input
                                  }
                                  return null; // If validation passes
                                },
                              ),


                            ),


                            SizedBox(
                              height: 32.h,
                            ),
                            CustomButton(
                              buttonText:'اطلب الان',
                              textColor: ColorManager.white,
                              backgroundColor: ColorManager.primaryColor,
                              onTap: () {
                                _submit(context,  financeCarList![index].id??0, nameController.text, phoneController.text, salaryController.text);
                              },
                            ),


                          ],
                        ),
                      )
                    );
                  });
                },
                child: Stack(
                  children: [
                    Center(
                      child:  CustomShimmerImage(
                          height: 300.h,
                          boxFit: BoxFit.fill,
                          image: financeCarList![index].image??''),
                    ),
                    Container(
                      height: 300.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.8),

                            ],
                          )
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 0.w,
                      right: 0.w,
                      child: Center(
                        child:  Text(financeCarList![index].name??'',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,),),
                      ),),
                  ],
                ),
              )
            );
          },
        ) :  const CircularProgressIndicator(color: Colors.red,),
      )
    );
  }
}
