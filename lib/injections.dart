import 'package:automobile_project/data/repository_implemintation/admin_repo_imp.dart';
import 'package:automobile_project/data/repository_implemintation/fav_repository.dart';
import 'package:automobile_project/data/repository_implemintation/general_repository_imp.dart';
import 'package:automobile_project/domain/repository/admin/admin_repository.dart';
import 'package:automobile_project/domain/repository/agency/agency_repository.dart';
import 'package:automobile_project/domain/repository/fav_repository/fav_repository.dart';
import 'package:automobile_project/domain/repository/general/general_repositry.dart';
import 'package:automobile_project/domain/use_case/admin/admin_use_case.dart';
import 'package:automobile_project/domain/use_case/agency/all_agency_use_case.dart';
import 'package:automobile_project/domain/use_case/authentication_use_case/end_user_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/body_shape_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/car_colors_use_case.dart';
import 'package:automobile_project/domain/use_case/fav_use_case/fav_use_case.dart';
import 'package:automobile_project/domain/use_case/general/sliders_use_case.dart';
import 'package:automobile_project/domain/use_case/general/track_request_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_cities_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_districts_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/show_rooms_use_case.dart';
import 'package:automobile_project/presentation/agency/all_agency/view_model/agency_view_model.dart';
import 'package:automobile_project/presentation/auth/show_room_login/view_model/show_room_login_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/show_room_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_cities_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_districts_veiw_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/body_shape_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brand_model_extension_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_model_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_brands_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/fuel_types_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/years_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/filter_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/presentation/finance_car/view_model/finance_car_view_model.dart';
import 'package:automobile_project/presentation/guarantee_cars/view_model/admin_view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../core/services/network/network_info.dart';
import '../data/data_sourse/remote/dio/dio_client.dart';
import '../data/data_sourse/remote/dio/logging_interceptor.dart';
import '../data/provider/local_auth_provider.dart';
import '../data/repository_implemintation/auth_repository.dart';
import '../data/repository_implemintation/local_repository_implementation/local_repository_imp.dart';
import '../domain/repository/authentication/authentication_repository.dart';
import '../domain/repository/local_repository/local_repo.dart';
import '../domain/use_case/authentication_use_case/show_room_login_use_case.dart';
import '../domain/use_case/local_use_cases/clear_user_data_usecase.dart';
import '../domain/use_case/local_use_cases/get_is_login_usecase.dart';
import '../domain/use_case/local_use_cases/get_user_data_usecase.dart';
import '../domain/use_case/local_use_cases/save_data_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/network/endpoints.dart';
import 'data/repository_implemintation/agency_repository.dart';
import 'data/repository_implemintation/drop_down/drop_down_repository.dart';
import 'data/repository_implemintation/finance_car_repository_imp.dart';
import 'data/repository_implemintation/show_rooms_repository.dart';
import 'domain/repository/drop_down/drop_down_repository.dart';
import 'domain/repository/finance_car/finance_car_repository.dart';
import 'domain/repository/show_rooms/show_rooms_repository.dart';
import 'domain/use_case/drop_down/brand_model_extensions_use_case.dart';
import 'domain/use_case/drop_down/brand_models_use_case.dart';
import 'domain/use_case/drop_down/brands_use_case.dart';
import 'domain/use_case/drop_down/car_features_use_case.dart';
import 'domain/use_case/drop_down/car_status_use_case.dart';
import 'domain/use_case/drop_down/fuel_type_use_case.dart';
import 'domain/use_case/drop_down/mechanical_use_case.dart';
import 'domain/use_case/drop_down/years_use_case.dart';
import 'domain/use_case/finance_car/finance_car_use_case.dart';
import 'domain/use_case/local_use_cases/get_user_role_usecase.dart';
import 'domain/use_case/local_use_cases/save_role_usecase.dart';
import 'domain/use_case/local_use_cases/save_user_usecase.dart';
import 'domain/use_case/show_rooms/shoow_room_sell_car_use_case.dart';
import 'domain/use_case/show_rooms/show_room_branches_use_case.dart';
import 'presentation/auth/login/view_model/end_user_view_model.dart';
import 'presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'presentation/bottom_navigation_bar/pages/notifications/view_model.dart';
import 'presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_colors_view_model.dart';
import 'presentation/favourites/view_model/fav_view_model.dart';
import 'presentation/filter_page/view_model/brandModelChnageViewModel.dart';
import 'presentation/filter_page/view_model/filter_page_view_model.dart';
import 'presentation/latest_new_cars/view_model/agency_new_cars_view_Model.dart';
import 'presentation/latest_new_cars/view_model/show_room_new_cars_view_model.dart';
import 'presentation/my_cars_to_sell/view model/get_my_cars_model_view.dart';
import 'presentation/sell_car_form_page/view_model/sell_change_car_view_model.dart';
import 'presentation/sort_by/view_model/sort_by_model_view.dart';
import 'presentation/static_pages/view_model.dart';
import 'presentation/track_ur_request/view_model/track_ur_request_view_model.dart';
import 'presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'presentation/used_cars/view_model/user_used_cars_view_model.dart';

//service locator
final sl = GetIt.instance;

Future<void> init() async {
  ///Use Case
  // local
  sl.registerLazySingleton(() => SaveTokenDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => SaveUserDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => ClearUserDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetIsUserLoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserRoleUseCase(repository: sl()));
  sl.registerLazySingleton(() => SaveRoleDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCitiesUseCase(sl())) ;
  sl.registerLazySingleton(() => GetDistrictsUseCase(sl())) ;
  sl.registerLazySingleton(() => GetMyCarUseCase(sl())) ;

  //Auth
  sl.registerLazySingleton(() => ShowRoomLoginUseCase(sl()));
  sl.registerLazySingleton(() => EndUserLoginUseCase(sl()));
  sl.registerLazySingleton(() => ShowRoomsUseCase(sl()));
  sl.registerLazySingleton(() => AllAgencyUseCase(sl()));
  sl.registerLazySingleton(() => CarBrandsUseCase(sl()));
  sl.registerLazySingleton(() => CarBrandsModelUseCase(sl()));
  sl.registerLazySingleton(() => YearsUseCase(sl()));
  sl.registerLazySingleton(() => MechanicalUseCase(sl()));
  sl.registerLazySingleton(() => BodyShapeUseCase(sl()));
  sl.registerLazySingleton(() => CarBrandsModelExtensionUseCase(sl()));
  sl.registerLazySingleton(() => FuelTypeUseCase(sl()));
  sl.registerLazySingleton(() => CarColorsUseCase(sl()));
  sl.registerLazySingleton(() => ShowRoomsBranchesUseCase(sl()));
  sl.registerLazySingleton(() => ShowRoomsSellCarUseCase(sl()));
  sl.registerLazySingleton(() => CarStatusUseCase(sl()));
  sl.registerLazySingleton(() => CarFeaturesUseCase(sl()));
  sl.registerLazySingleton(() => FavUseCase(sl()));
  sl.registerLazySingleton(() => SlidersUseCase(sl()));
  sl.registerLazySingleton(() => FinanceCarUseCase(sl()));
  sl.registerLazySingleton(() => AdminUseCase(sl()));
  sl.registerLazySingleton(() => TrackYourRequestUseCase(sl()));

  ///View Model
  sl.registerLazySingleton(() => ShowRoomLoginViewModel(saveUserDataUseCase: sl(), loginUseCase: sl(), saveUserTokenUseCase: sl(), saveRoleUseCase: sl() , getUserDataUseCase: sl() , getUserRoleUseCase: sl()));
  sl.registerLazySingleton(() => EndUserViewModel(saveUserDataUseCase: sl(), loginUseCase: sl(), saveUserTokenUseCase: sl(), saveRoleUseCase: sl() , getUserDataUseCase: sl()));
  sl.registerLazySingleton(() => FinanceCarViewModel( financeCarUseCase: sl()));
  sl.registerLazySingleton(() => ShowRoomsViewModel(showRoomsUseCase: sl()));
  sl.registerLazySingleton(() => GetCitiesViewModel(citiesUseCase: sl()));
  sl.registerLazySingleton(() => GetDistrictsViewModel(citiesUseCase: sl()));
  sl.registerLazySingleton(() => GetMyCarsViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => AgencyViewModel(showRoomsUseCase: sl()));
  sl.registerLazySingleton(() => FilterViewModel());
  sl.registerLazySingleton(() => CarBrandsViewModel(brandsUseCase: sl()));
  sl.registerLazySingleton(() => CarBrandsModelViewModel(brandModelsUseCase: sl()));
  sl.registerLazySingleton(() => YearsViewModel(yearsUseCase: sl()));
  sl.registerLazySingleton(() => CarMechanicalViewModel(mechanicalUseCase: sl()));
  sl.registerLazySingleton(() => BodyShapeViewModel(bodyShapeUseCase: sl()));
  sl.registerLazySingleton(() => CarBrandsModelExtensionViewModel(carBrandsModelExtensionUseCase: sl()));
  sl.registerLazySingleton(() => FuelTypeViewModel(fuelTypeUseCase: sl()));
  sl.registerLazySingleton(() => ShowRoomsBranchesViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => ShowRoomSellCarViewModel(showRoomsSellUseCase: sl()));
  sl.registerLazySingleton(() => CarStatusViewModel(carStatusUseCase: sl()));
  sl.registerLazySingleton(() => AllNotificationViewModel(showSlidersUseCase: sl()));
  sl.registerLazySingleton(() => CarFeaturesViewModel(carFeaturesUseCase: sl()));
  sl.registerLazySingleton(() => CarColorsViewModel(colorsUseCase: sl()));
  sl.registerLazySingleton(() => FilterPageViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => BrandModelChangeViewModel());
  sl.registerLazySingleton(() => SlidersViewModel(showSlidersUseCase: sl()));
  sl.registerLazySingleton(() => SellChangeCarViewModel(showSlidersUseCase: sl()));
  sl.registerLazySingleton(() => NewCarsShowRoomViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => NewCarsAgencyViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => UsedCarsShowRoomViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => NewCarsUserViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => AdminViewModel(adminUseCase: sl()));
  sl.registerLazySingleton(() => TrackYourRequestViewModel(showSlidersUseCase: sl()));
  sl.registerLazySingleton(() => SortPageViewModel(showRoomsBranchesUseCase: sl()));
  sl.registerLazySingleton(() => StaticPagViewModel(showSlidersUseCase: sl()));
  sl.registerLazySingleton(() => FavViewModel(
    favUseCase: sl()
  ));

  ///Repository
  sl.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImp(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton<BaseAuthenticationRepository>(
      () => AuthRepository(dioClient: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<BaseShowRoomsRepository>(
      () => ShowRoomsRepository(dioClient: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<BaseAgencyRepository>(
      () => ShowAgencyRepository(dioClient: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<BaseDropDownsRepository>(
      () => DropDownRepository(dioClient: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<FavRepository>(
          () => ImpFavRepository(dioClient: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<GeneralRepository>(
          () => ImpGeneralRepository(dioClient: sl(), sharedPreferences: sl()));
 sl.registerLazySingleton<FinanceCarRepository>(
          () => ImpFinanceCarRepository(dioClient: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<AdminRepository>(
          () => ImpAdminRepo(dioClient: sl(), sharedPreferences: sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => DioClient(NetworkPath.hostName,
      loggingInterceptor: sl(), sharedPreferences: sl()));

  ///SERVICES REGISTER
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));

  ///providers
  sl.registerLazySingleton(
    () => LocalAuthProvider(
      getIsUserLoginUseCase: sl(),
      getUserRoleUseCase: sl(),
      getUserDataUseCase: sl(),
      clearUserDataUseCase: sl(),
    ),
  );
}
