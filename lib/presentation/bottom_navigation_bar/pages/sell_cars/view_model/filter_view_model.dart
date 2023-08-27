import 'package:flutter/cupertino.dart';

class FilterViewModel extends ChangeNotifier {
  List<String> _selectedItems = []; // List to hold selected items
  List<String> get selectedItems => _selectedItems;
  List<Map<String, dynamic>> items = [
    {
      'title': 'BMW',
      'subItems': ['Subitem 1', 'Subitem 2', 'Subitem 3']
    },

    {
      'title': 'MG',
      'subItems': ['Subitem 4', 'Subitem 5', 'Subitem 6']
    },

    {
      'title': 'Alfa Romeo',
      'subItems': ['Subitem 7', 'Subitem 8', 'Subitem 9']
    }
  ];
  updateBrands(bool value, String item) {
    if (value == true) {
      _selectedItems.add(item);
    } else {
      _selectedItems.remove(item);
    }
    notifyListeners();
  }
}
