// ignore_for_file: use_build_context_synchronously





import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/core/resources/app_assets.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/resources/app_values.dart';
import 'package:automobile_project/core/resources/font_manager.dart';
import 'package:automobile_project/core/resources/spaces.dart';
import 'package:automobile_project/data/models/base_response/base_model.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_cities_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_districts_veiw_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/presentation/component/text_icon.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:provider/provider.dart';

import 'add_branch.dart';
import 'edit_branch.dart';


class ShowAgencyBranches extends StatefulWidget {
  const ShowAgencyBranches({Key? key}) : super(key: key);

  @override
  State<ShowAgencyBranches> createState() => _ShowAgencyBranchesState();
}

class _ShowAgencyBranchesState extends State<ShowAgencyBranches> {
  late Future<ResponseModel<List<ShowRoomBranchModel>>> _roomBranchModel  ;
  String _selectedCity = "1" ;
  String _selecteddistrict = "1" ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 0) , ()async{
      final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: false) ;
      // final getCitiesProvider = Provider.of<GetCitiesViewModel>(context , listen: false) ;
      (await showRoomsProvider.getBranches(context: context, id: 1))  ;
      // await getCitiesProvider.getCities(context: context,) ;
      if (kDebugMode) {


      }

    }) ;

    Provider.of<GetCitiesViewModel>(context , listen: false).getCities(context: context) ;


  }

  @override
  Widget build(BuildContext context) {
    final showRoomsProvider = Provider.of<ShowRoomsBranchesViewModel>(context , listen: true) ;

    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.myBranches),
        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.black,
            )),
      )) ,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // VerticalSpace(20.h) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TapEffect(
                      onClick: (){
                        showModalBottomSheet(context: context,
                            builder: (_)=> const AddBranchBottomSheet() ,
                            isScrollControlled: true,


                            backgroundColor: Colors.white ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.w) ,
                              topLeft: Radius.circular(15.w) ,
                            )
                          ) ,

                        ) ;
                      },
                      child: Container(
                        width: 380.w,
                        padding:  EdgeInsets.all(15.w) ,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor ,
                          borderRadius: BorderRadius.circular(10) ,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1) ,
                              blurRadius: 3 ,
                              offset: const Offset(0, 0) ,
                              spreadRadius: 3
                            )
                          ]
                        ),
                        child:  Center(
                          child: Text(translate(LocaleKeys.addNewBranch) , style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: FontSize.s18.sp,
                            color: ColorManager.white,
                          ), ),
                        ),
                      ),

                      ) ,




                ],
              ),
              // VerticalSpace(20.h) ,

              SizedBox(
                height: 20.h,
              ),

              showRoomsProvider.isLoading == false ?
              Column(
                children: List.generate(showRoomsProvider.showRoomsBranchesResponse!.data!.length, (index)
                => Container(
                  width: 380.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor ,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1) ,
                          spreadRadius: 1 ,
                          offset: const Offset(0, 0)
                        )
                      ]  ,
                    borderRadius: BorderRadius.circular(15.w)
                  ),
                   child: Column(
                     children:[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,

                         children: [
                           TextIconWidget(
                             icon: Icons.drive_file_rename_outline,

                             title: "${showRoomsProvider.showRoomsBranchesResponse!.data![index].name}",
                           ) ,

                           Column(
                             children: [
                               TapEffect(onClick: ()async{
                                 await Provider.of<GetCitiesViewModel>(context , listen: false).getCities(context: context).then((value){


                                 }) ;
                                 await Provider.of<GetDistrictsViewModel>(context , listen: false)
                                     .getCities(context: context, id: int.parse(showRoomsProvider.showRoomsBranchesResponse!.data![index].cityId!)).then((value){


                                 }) ;
                                 showModalBottomSheet(context: context,
                                   builder: (_)=>  EditBranchBottomSheet(model: showRoomsProvider.showRoomsBranchesResponse!.data![index]) ,
                                   isScrollControlled: true,


                                   backgroundColor: Colors.white ,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.only(
                                         topRight: Radius.circular(15.w) ,
                                         topLeft: Radius.circular(15.w) ,
                                       )
                                   ) ,

                                 ) ;
                               },
                                   child: const Icon(Icons.edit_note_sharp , color: ColorManager.primaryColor,))
                             ],
                           )
                         ],
                       ),
                       SizedBox(
                         height: 10.h,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           TextIconWidget(
                             icon: Icons.home_filled,

                             title: "${showRoomsProvider.showRoomsBranchesResponse!.data![index].address}",
                           ) ,
                           TapEffect(onClick: (){
                             showRoomsProvider.hideBranch(context: context, id: showRoomsProvider.showRoomsBranchesResponse!.data![index].id!) ;
                           }, child: const Icon(Icons.delete_forever , color: ColorManager.primaryColor,))
                         ],
                       ) ,
                       SizedBox(
                         height: 10.h,
                       ),
                       TextIconWidget(
                         icon: Icons.place,

                         title: "${showRoomsProvider.showRoomsBranchesResponse!.data![index].city},${showRoomsProvider.showRoomsBranchesResponse!.data![index].district}",
                       ) ,

                     ]
                   ),
                )
                ),
              ) : SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: MyProgressIndicator(
                    width: 80.h,
                    height: 80.h,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}








