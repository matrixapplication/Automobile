import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/favourites/favourites/favourites_page.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view/my_cars_to_sell_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/resources/resources.dart';
import '../../../translations/local_keys.g.dart';
import '../../component/components.dart';
import '../bottom_navigation_bar.dart';

class BottomNavigationPage extends StatefulWidget {
  int selectedIndex;

  BottomNavigationPage({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {


  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      final userProvider =  Provider.of<LocalAuthProvider>(context,listen: false) ;
      await userProvider.getEndUserData();
      await userProvider.getUserData();

    });
  }
 int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const SellCarsPage(),
      const NotificationsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;
    if (kDebugMode) {
      print(userProvider.role) ;
    }
    if(shared?.getString("role") == "showroom" ||  shared?.getString("role") == "agency"){
      screens[2] = const MyCarsToSellPage() ;
    }else{
      screens[2] = const FavouritesPage() ;

    }
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            //  color: Colors.green,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            child: BottomNavigationBar(
              currentIndex: widget.selectedIndex,
              onTap: (index) async{
                setState((){
                  if(userProvider.role == "showroom" || userProvider.role == "agency"){
                    if(userProvider.user != null  ){
                      widget.selectedIndex = index ;
                    }else{
                      showCustomSnackBar(message: translate(LocaleKeys.pleaseLogin), context: context) ;
                    }
                  }else{
                    if(userProvider.endUser != null){
                      print("auth") ;
                      widget.selectedIndex = index ;
                    }else{
                      print("un auth") ;
                      showCustomSnackBar(message: LocaleKeys.pleaseLogin.tr(), context: context) ;
                    }
                  }
                }) ;
              },
              elevation: 2,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              type: BottomNavigationBarType.fixed,
              iconSize: 10,
              backgroundColor: Colors.white,
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              selectedLabelStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeightManager.semiBold),
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeightManager.medium),
              selectedItemColor: ColorManager.black,
              unselectedItemColor: ColorManager.black,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                  icon: CustomSvgImage(
                    image: AssetsManager.homeIcon,
                    color: widget.selectedIndex == 0
                        ? ColorManager.primaryColor
                        : null,
                  ),
                  label:  translate(LocaleKeys.home),
                ),
                BottomNavigationBarItem(
                  icon: CustomSvgImage(
                    image: AssetsManager.sellCarIcon,
                    height: 28.h,
                    color: widget.selectedIndex == 1
                        ? ColorManager.primaryColor
                        : null,
                  ),
                  label:  translate(LocaleKeys.sellCar),
                ),
                shared?.getString("role") == "showroom" ||  shared?.getString("role") == "agency" ?
                BottomNavigationBarItem(
                  icon: CustomSvgImage(
                    image: AssetsManager.carDealersIcon,
                    height: 30.h,
                    color: widget.selectedIndex == 2
                        ? ColorManager.primaryColor
                        : null,
                  ),
                  label:  "My Cars",
                ) :
                BottomNavigationBarItem(
                  icon: CustomSvgImage(
                    image: AssetsManager.faveIcon,
                    height: 28.h,
                    color: widget.selectedIndex == 2
                        ? ColorManager.primaryColor
                        : null,
                  ),
                  label:  translate(LocaleKeys.favourites),
                ),
                BottomNavigationBarItem(
                  icon: CustomSvgImage(
                    image: AssetsManager.profileIcon,
                    color: widget.selectedIndex == 3
                        ? ColorManager.primaryColor
                        : null,
                  ),
                  label:  translate(LocaleKeys.profile),
                ),
              ],
            ),
          ),
        ),
        body: screens[widget.selectedIndex]);
  }
}
