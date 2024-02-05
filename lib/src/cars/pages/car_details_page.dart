import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../injections.dart';
import '../../../presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import '../../../presentation/latest_new_cars/view/new_car_details.dart';

///  Created by harbey on 2/5/2024.
class CarDetailsPage extends StatelessWidget {
  final int id;
  const CarDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          ShowRoomSellCarViewModel(showRoomsSellUseCase: sl())
            ..fetchCarDetails(context: context, id: id),
      child: Consumer<ShowRoomSellCarViewModel>(
        builder: (context, provider, child) {
          return provider.isLoadingDetails
              ? const Material(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()))
              :
            LatestNewCarsDetails(
            carModel: provider.carDetails!,
            isShowRoom: false,
          );
        },
      ),
    );
  }
}
