import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/show_agency_branchs.dart';
import 'package:automobile_project/presentation/setting/setting.dart';
import 'package:automobile_project/presentation/sort_by/sort_by.dart';
import 'package:automobile_project/presentation/static_pages/privacy.dart';
import 'package:automobile_project/presentation/static_pages/terms.dart';
import 'package:automobile_project/presentation/static_pages/who_we_are.dart';
import 'package:automobile_project/presentation/track_ur_request/track_ur_request.dart';
import 'package:automobile_project/presentation/update_cars/pages/update_car_photos_page.dart';
import 'package:automobile_project/presentation/update_cars/pages/update_cars_page.dart';
import 'package:automobile_project/presentation/update_cars/pages/updatel_car_customer_data_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/agency/agency_profile/agency_profile_page.dart';
import '../../presentation/agency/all_agency/view/all_agency_page.dart';
import '../../presentation/auth/login/view/page/login_page.dart';
import '../../presentation/auth/otp/view/otp_page.dart';
import '../../presentation/auth/show_room_login/view/page/show_room_login_page.dart';
import '../../presentation/auth/sign_up/view/page/signup_page.dart';
import '../../presentation/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../presentation/bottom_navigation_bar/pages/bottom_navigation_page.dart';
import '../../presentation/bottom_navigation_bar/pages/profile/pages/edit_profile.dart';
import '../../presentation/bottom_navigation_bar/pages/sell_cars/pages/sell_car_customer_data_page.dart';
import '../../presentation/car_show_rooms/view/car_show_rooms_profile_page.dart';
import '../../presentation/car_show_rooms/view/car_show_rooms_page.dart';
import '../../presentation/component/screens/undefined_route_screen.dart';
import '../../presentation/favourites/favourites/favourites_page.dart';
import '../../presentation/filter_page/view/filter_page.dart';
import '../../presentation/filter_page/component/filter_cars_details.dart';
import '../../presentation/guarantee_cars/view/guarantee_car_details.dart';
import '../../presentation/guarantee_cars/view/guarantee_car_page.dart';
import '../../presentation/latest_new_cars/view/new_car_details.dart';
import '../../presentation/latest_new_cars/view/new_car_page.dart';
import '../../presentation/my_cars_to_sell/view/my_cars_to_sell_page.dart';
import '../../presentation/onbaording/on_boarding.dart';
import '../../presentation/bottom_navigation_bar/pages/sell_cars/pages/sell_car_photos_page.dart';
import '../../presentation/profile/show_user_profile/show_user_profile.dart';
import '../../presentation/sell_car_form_page/sell_car_form_page.dart';
import '../../presentation/splash/splash.dart';
import '../../presentation/static_pages/sell_buy_car_privacy.dart';
import '../../presentation/test_check_list/test_check_list.dart';
import '../../presentation/used_cars/view/used_car_details.dart';
import '../../presentation/used_cars/view/used_cars_page.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    // print("RouteGenerator onGenerateRoute ${settings.name}");
    if (settings.name!.contains('/ar/cars/show/') ||
        settings.name!.contains('/en/cars/show/')) {
      print("RouteGenerator onGenerateRoute ${settings.name}");
      final args = settings.arguments as Map<String, dynamic>;
      return platformPageRoute(LatestNewCarsDetails(
        isShowRoom: args["isShowRoom"],
        carModel: args['carModel'],
      ));
    }
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen());
      case Routes.appLinkCarAR:
        return platformPageRoute(const LatestNewCarPage());
      case Routes.appLinkCarEN:
        return platformPageRoute(const LatestNewCarPage());
      case Routes.onBoardingPage:
        return platformPageRoute(const OnBoardingPage());

      case Routes.loginScreen:
        return platformPageRoute(const LoginPage());
      case Routes.signupScreen:
        return platformPageRoute(const SignUpScreen());
      case Routes.otpPage:
        return platformPageRoute(const OtpPage());
      case Routes.bottomNavigationBar:
        Map<String , dynamic>? args = settings.arguments as Map<String, dynamic>?;
        return platformPageRoute(BottomNavigationPage(selectedIndex: args == null ? 0 :args['selectedIndex']??0,));
      case Routes.homeScreen:
        return platformPageRoute(const HomeScreen());
      case Routes.latestNewCarPage:
        return platformPageRoute(const LatestNewCarPage());
      case Routes.myCarsToSellPage:
        return platformPageRoute(const MyCarsToSellPage());
      case Routes.latestNewCarsDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(LatestNewCarsDetails(
          isShowRoom: args["isShowRoom"],
          carModel: args['carModel'],
        ));
      case Routes.usedCarsPage:
        return platformPageRoute(const UsedCarsPage());
      case Routes.usedCarDetailsPage:
        final args = settings.arguments as Map<String, dynamic>;

        return platformPageRoute(UsedCarDetailsData(
          carModel: args['carModel'],
          isShowRoom: args['isShowRoom'],
        ));
      case Routes.carShowRoomPage:
        return platformPageRoute(const CarShowRoomPage());
      case Routes.agencyProfilePage:
        final args = settings.arguments as Map<String, dynamic>;

        return platformPageRoute(AgencyProfilePage(
          showRoomModel: args['showRoomModel'],
        ));
      case Routes.carShowRoomProfilePage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(CarShowRoomProfilePage(
            showRoomModel: args['showRoomModel'],
          tab: args['tab'],
        ));
      case Routes.filterPage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute( FilterPage(
          type: args['type'],
        ));
      case Routes.editProfilePage:
        return platformPageRoute(const EditProfilePage());
      case Routes.favouritesPage:
        return platformPageRoute(const FavouritesPage());
      case Routes.sellCarPhotosPage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(SellCarPhotosPage(carData: args["carData"]));
      case Routes.sellCarCustomerDataPage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(
          SellCarCustomerDataPage(
              carData: args["carData"],
              mainImage: args["mainImage"],
              images: args["images"]),
        );
      case Routes.testCheckList:
        return platformPageRoute(const TestCheckList());
      case Routes.selCarFormPage:
        return platformPageRoute(const SelCarFormPage());
      case Routes.showUserProfile:
        final args = settings.arguments as Map<String, dynamic>;

        return platformPageRoute( ShowUserProfile(carModel: args['carModel'],));
      case Routes.guaranteeCarPage:
        return platformPageRoute(const GuaranteeCarPage());
      case Routes.filtersCarsDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(FiltersCarsDetails(
          name: args['name'],
          id: args['id'],
        ));
      case Routes.sellCarsPage:
        return platformPageRoute(const SellCarsPage());
      case Routes.guaranteeCarDetailsData:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(GuaranteeCarDetailsData(
          adminCars: args['adminCars'],
        ));
      case Routes.allAgencyPage:
        return platformPageRoute(const AllAgencyPage());

      case Routes.showRoomLoginPage:
        return platformPageRoute(const ShowRoomLoginPage());
      case Routes.showBranches:
        return platformPageRoute(const ShowAgencyBranches());
      case Routes.updateCarPage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(UpdateCarsPage(
          carModel: args['carModel'],
        ));
      case Routes.updateCarPhotosPage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(UpdateCarPhotosPage(
          carData: args['carData'],
          oldImages: args['oldImages'],
          oldMainImage: args['oldMainImage'], id: args['id'],
        ));
      case Routes.updateCarCustomerPage:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(UpdateCarCustomerDataPage(
            carData: args['carData'],
            mainImage: args['mainImage'],
            images: args['images']));

      case Routes.trackYourRequest:
        return platformPageRoute( const TrackUrRequest());
    case Routes.sortPage:
      final args = settings.arguments as Map<String, dynamic>;

      return platformPageRoute( SortPage(
        status: args['status'],
      ) );
    case Routes.whoWeAre:
      return platformPageRoute( const WhoWeAre());
    case Routes.terms:
      return platformPageRoute( const TermsConditions());
    case Routes.privacy:
      return platformPageRoute( const Privacy());
    case Routes.settings:
      return platformPageRoute( const Settings());
    case Routes.carReturn:
      return platformPageRoute( const SellBuyPrivacy());

/*      case Routes.checkoutScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(CheckoutScreen(
          cartData: args["cartData"],
        ));*/

      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
