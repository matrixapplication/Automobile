import 'dart:ffi';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/filter_page/view_model/filter_page_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class SearchBarRes extends StatelessWidget {
  final Color? borderColor;
  final Color? iconColor;
  final Color? hintColor;
  final Color? textColor;

  const SearchBarRes(
      {Key? key,
      this.borderColor,
      this.iconColor,
      this.hintColor,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {


    final filterPageProvider =
    Provider.of<FilterPageViewModel>(context, listen: true);

    return SizedBox(
      width: 320.w,
      height: 50.h,
      child: TypeAheadField(
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 4)),
        hideOnEmpty: true,
        hideSuggestionsOnKeyboardHide: false,
        keepSuggestionsOnSuggestionSelected: true,
        hideOnLoading: true,
        textFieldConfiguration: TextFieldConfiguration(
            style: TextStyle(
              color: textColor ?? ColorManager.blackColor1C1C1C,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              filled: true,
              suffixIcon: filterPageProvider.isLoading ?
              MyProgressIndicator(
                width: 10.h,
                height: 10.h,
                size: 10.h,
              ) : const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: borderColor ?? ColorManager.blackColor1C1C1C)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: borderColor ?? ColorManager.blackColor1C1C1C)),
              fillColor: ColorManager.white,
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                child: Icon(Icons.search,
                    size: 20.h,
                    color: iconColor ?? ColorManager.blackColor1C1C1C),
              ),
              hintStyle: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                  fontSize: 15.h,
                  color: ColorManager.blackColor1C1C1C),
              hintText: translate(LocaleKeys.search),
              // contentPadding: const EdgeInsets.only(
              //     left: 16, right: 16.0, top: 0, bottom: 0),
            ),
            onSubmitted: (String value) async {

              await filterPageProvider.getMyCars(
                  context: context,
                  states: null,
                  brand: null,
                  isAll: true,
                  driveType: null,
                  search:  value,
                  fuelType: null,
                  startPrice: null,
                  endPrice: null,
                  startYear: null,
                  carModel: null,
                  endYear: null).then((value1) => NavigationService.push(context, Routes.filtersCarsDetails , arguments: {
                    "id" : null ,
                    "name" : value
              }));
            }),


        suggestionsCallback: (String? pattern) => [],
        itemBuilder: (BuildContext context, itemData) => Container(),
        onSuggestionSelected: (Object? suggestion) {},
      ),
    );
  }
}
