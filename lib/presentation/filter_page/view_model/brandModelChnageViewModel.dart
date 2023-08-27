import 'package:flutter/material.dart';

class BrandModelChangeViewModel extends ChangeNotifier{
  String? _statusIndex  = null;

  String?  get statusIndex => _statusIndex;

  String? _brandIndex =null;

  String?  get brandIndex => _brandIndex;


  double? _priceStart = null ;

  double?  get priceStart => _priceStart;
  double? _priceEnd  = null;

  double?  get priceEnd => _priceEnd;



  String? _startYear ;

  String?  get startYear => _startYear;


  String? _endYear ;

  String?  get endYear => _endYear;


  changePriceIndex({required double start , required double end }) {
    _priceStart = start ;
    _priceEnd = end ;
    notifyListeners();
  }

  changeStatusIndex(String?  index) {
    _statusIndex = index;
    notifyListeners();
  }


  changeBrandIndex(String?  index) {
    _brandIndex = index;
    notifyListeners();
  }


  startYearSelect(String?  index) {
    _startYear = index;
    notifyListeners();
  }
  endYearSelect(String?  index) {
    _endYear = index;
    notifyListeners();
  }


}