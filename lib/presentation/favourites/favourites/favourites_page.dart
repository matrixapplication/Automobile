import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/components.dart';
import '../../used_cars/components/users_used_cars_component.dart';
import '../components/favourite_grid_component.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child:  MyAppbar(
        title: translate(LocaleKeys.favourites),
        backgroundColor: ColorManager.primaryColor,
        centerTitle: true,
        titleColor: ColorManager.white,

        actions: [],
        leading: null,
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: const FavouriteGridComponent(),
      ),
    );
  }
}
