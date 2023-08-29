import 'package:automobile_project/presentation/agency/all_agency/view_model/agency_view_model.dart';
import 'package:automobile_project/presentation/auth/login/view_model/end_user_view_model.dart';
import 'package:automobile_project/presentation/auth/show_room_login/view_model/show_room_login_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/show_room_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_cities_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_districts_veiw_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/body_shape_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brand_model_extension_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_model_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_colors_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/fuel_types_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/years_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/filter_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/presentation/filter_page/view_model/filter_page_view_model.dart';
import 'package:automobile_project/presentation/guarantee_cars/view_model/admin_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/data/provider/local_auth_provider.dart';
import '/injections.dart';
import 'presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'presentation/filter_page/view_model/brandModelChnageViewModel.dart';
import 'presentation/latest_new_cars/view_model/agency_new_cars_view_Model.dart';
import 'presentation/latest_new_cars/view_model/show_room_new_cars_view_model.dart';
import 'presentation/my_cars_to_sell/view model/get_my_cars_model_view.dart';
import 'presentation/sell_car_form_page/view_model/sell_change_car_view_model.dart';
import 'presentation/sort_by/view_model/sort_by_model_view.dart';
import 'presentation/static_pages/view_model.dart';
import 'presentation/track_ur_request/view_model/track_ur_request_view_model.dart';
import 'presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'presentation/used_cars/view_model/user_used_cars_view_model.dart';

  class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({Key? key, required this.child}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<LocalAuthProvider>()),
        ChangeNotifierProvider(create: (context) => sl<ShowRoomLoginViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<FilterViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<ShowRoomsViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<AgencyViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<CarBrandsViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<CarBrandsModelViewModel>()),
        //mahmoud
        ChangeNotifierProvider(create: (context) => sl<YearsViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<CarMechanicalViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<BodyShapeViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<CarBrandsModelExtensionViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<FuelTypeViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<ShowRoomsBranchesViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<ShowRoomSellCarViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<CarStatusViewModel>()),
        ChangeNotifierProvider(create: (context) => sl<CarFeaturesViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<GetCitiesViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<GetDistrictsViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<GetMyCarsViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<EndUserViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<FilterPageViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<BrandModelChangeViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<CarColorsViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<FavViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<SlidersViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<SellChangeCarViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<AdminViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<NewCarsShowRoomViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<NewCarsAgencyViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<UsedCarsShowRoomViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<NewCarsUserViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<TrackYourRequestViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<SortPageViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<StaticPagViewModel>()),
      ],

      child: child,
    );
  }
}
