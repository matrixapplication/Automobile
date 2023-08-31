import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../../main.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/components.dart';
import '../components/favourite_grid_component.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: MyAppbar(
            title: translate(LocaleKeys.favourites),
            backgroundColor: ColorManager.primaryColor,
            centerTitle: true,
            titleColor: ColorManager.white,
            leading: TapEffect(
                onClick: () {
                  NavigationService.push(context, Routes.bottomNavigationBar);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.white,
                  textDirection: shared!.getString("lang") == "en"
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
            actions: [],
// leading: TapEffect,
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: const FavouriteGridComponent(),
      ),
    );
  }
}
