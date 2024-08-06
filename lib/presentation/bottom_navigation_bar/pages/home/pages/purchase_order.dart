import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/utils/alerts.dart';
import '../../../../../core/widget/choose_from_list_widget.dart';
import '../../../../../core/widget/drop_down.dart';
import '../../../../../data/models/basic_model/basic_model.dart';
import '../../../../../data/models/puechase_order.dart';
import '../../../../../translations/local_keys.g.dart';
import '../../../../component/custom_text.dart';
import '../../../../component/custom_text_field.dart';
import '../../sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import '../view_model/show_room_view_model.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  List<BasicModel> list=[];
  @override
  void initState() {
     Provider.of<CarBrandsViewModel>(context, listen: false).getBrands(context: context).then((value) {
       list =value!.data!;
       setState(() {

       });
     });
    super.initState();
  }
  DropDownItem? item;
  final TextEditingController _nameController =TextEditingController();
  final TextEditingController _phoneController =TextEditingController();
  final formKey = GlobalKey<FormState>();

  int? carId;
  String payType='cash';
  String? language = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:  const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100,),
                Center(
                  child: Text(translate(LocaleKeys.purchaseOrder),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.red
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                CustomText(
                    text: LocaleKeys.fullName.tr(),
                    textStyle: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(
                        color: ColorManager.greyColor515151,
                        fontWeight: FontWeightManager.medium,
                        fontSize: 14)),
                const SizedBox(height: 10,),
                CustomTextField(
                  borderColor: Colors.grey.shade300,
                    controller: _nameController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return translate(LocaleKeys.required);
                      }
                      return null;
                    },
                    prefixIcon: const Icon(
                      Icons.person,
                      // size: 30.h,
                    ),),
                const SizedBox(height: 16,),

                CustomText(
                    text: LocaleKeys.carBrand.tr(),
                    textStyle: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(
                        color: ColorManager.greyColor515151,
                        fontWeight: FontWeightManager.medium,
                        fontSize: 14)),
                const SizedBox(height: 10,),
                DropDownField(
                    prefixIcon: Icons.menu_rounded,
                    height: 20,
                    hint: '',
                    items:list.isNotEmpty?
                    list.map((e) =>   DropDownItem(
                        id: e.id!.toString(),
                        title:e.name,
                        value: e.name
                    )).toList():
                     [
                      const DropDownItem(
                        id: '',
                        title: ''),
                    ],
                    onChanged: (item) {
                      carId=int.parse(item!.id!);
                    }
                ),
                const SizedBox(height: 16,),
                CustomText(
                    text: LocaleKeys.phone.tr(),
                    textStyle: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(
                        color: ColorManager.greyColor515151,
                        fontWeight: FontWeightManager.medium,
                        fontSize: 14)),
                const SizedBox(height: 10,),
                CustomTextField(
                  borderColor: Colors.grey.shade300,
                  textInputType: TextInputType.phone,
                  controller: _phoneController,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return translate(LocaleKeys.required);
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.phone,
                    // size: 30.h,
                  ),),
                const SizedBox(height: 36,),
                ChooseFromListItemWidget(
                  width:170,
                  radius: 4,
                  onChoose: (ChooseItemListModel item) {
                    if(item.id==1){
                      payType='cash';
                    }else{
                      payType='finance';
                    }
                  },
                  items: [
                    ChooseItemListModel(id: 1, title: LocaleKeys.cash.tr(),),
                    ChooseItemListModel(id: 2, title: LocaleKeys.finance.tr(),),
                  ],),
                const SizedBox(height: 100,),
                Center(
                  child: ElevatedButton(
                       style: ButtonStyle(
                           shape: MaterialStateProperty.all(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(4),
                             ),
                           ),
                           minimumSize: MaterialStateProperty.all(const Size(100, 35)), // Set width and height here
                           backgroundColor: MaterialStateProperty.all(Colors.red)
                       ),
                      onPressed: (){
                         if(formKey.currentState!.validate()){
                           if(carId==null){
                             Alerts.showSnackBar(context, 'Choose Car Brand',forError: true);

                           }else{
                             PurchaseOrderParams params =PurchaseOrderParams(
                                 name: _nameController.text, carId: carId!, phone: _phoneController.text,
                                 payType: payType);
                             Provider.of<ShowRoomsViewModel>(context, listen: false)
                                 .sendPurchaseOrder(params,context);
                           }
                         }


                      },
                      child: Text(
                          LocaleKeys.done.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                      )),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
