import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/fuel_type_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/fuel_type_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/show_room_branches_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class ShowRoomsBranchesViewModel extends ChangeNotifier {
  final ShowRoomsBranchesUseCase _showRoomsBranchesUseCase;

  ShowRoomsBranchesViewModel({
    required ShowRoomsBranchesUseCase showRoomsBranchesUseCase,
  }) : _showRoomsBranchesUseCase = showRoomsBranchesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<ShowRoomBranchModel>>? _showRoomsBranchesResponse;

  ResponseModel<List<ShowRoomBranchModel>>? get showRoomsBranchesResponse {
    return _showRoomsBranchesResponse;
  }

  ResponseModel<ShowRoomBranchModel>? _newBranch  ;

  List<ShowRoomBranchModel> _branchList = [] ;
  List<ShowRoomBranchModel> get branchList {
    return _branchList ;
  }




  Future<ResponseModel<List<ShowRoomBranchModel>?>?> getBranches(
      {required BuildContext context, required id}) async {
    _isLoading = true;
    notifyListeners();

    final response =
        await _showRoomsBranchesUseCase.call(context: context, id: id);

    if (response.isSuccess) {
      ResponseModel<List<ShowRoomBranchModel>>? data = response;
      _showRoomsBranchesResponse = data;
      log("get Brands", _showRoomsBranchesResponse!.data!.toString());
    } else {
      if (kDebugMode) {
        print("Fail getBrands ${response.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future<ResponseModel<ShowRoomBranchModel?>> addBranch(
      {required BuildContext context, required formData}) async {
    _isLoading = true;
    notifyListeners();

    final response =
    await _showRoomsBranchesUseCase.add(context: context, formData: formData);

    if (response.isSuccess) {
      ResponseModel<ShowRoomBranchModel>? data = response;
      _newBranch = data;
      _showRoomsBranchesResponse?.data?.add(data.data!) ;
      print(_showRoomsBranchesResponse?.data) ;
    } else {
      if (kDebugMode) {
        print("Fail getBrands ${response.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future<ResponseModel<ShowRoomBranchModel?>> editBranch(
      {required BuildContext context, required formData , required int id}) async {
    _isLoading = true;
    notifyListeners();

    final response =
    await _showRoomsBranchesUseCase.edit(context: context, formData: formData, id: id);

    if (response.isSuccess) {
      ResponseModel<ShowRoomBranchModel>? data = response;
      _newBranch = data;

      if (kDebugMode) {
        print(_showRoomsBranchesResponse?.data) ;
      }
    } else {
      if (kDebugMode) {
        print("Fail edit branch ${response.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<ResponseModel<ShowRoomBranchModel?>> hideBranch(
      {required BuildContext context,required int id}) async {
    _isLoading = true;
    notifyListeners();

    final response =
    await _showRoomsBranchesUseCase.hide(context: context, id: id);

    if (response.isSuccess) {
      _showRoomsBranchesResponse!.data!.removeWhere((element) => element.id == id) ;
    } else {
      if (kDebugMode) {
        print("Fail edit branch ${response.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<ResponseModel<List<ShowRoomBranchModel>?>?> getBranchesById(
      {required BuildContext context, required id}) async {
    _isLoading = true;
    notifyListeners();

    final response =
    await _showRoomsBranchesUseCase.callById(context: context, id: id);

    if (response.isSuccess) {
      ResponseModel<List<ShowRoomBranchModel>>? data = response;
      _showRoomsBranchesResponse = data;

      _branchList.addAll(_showRoomsBranchesResponse!.data!.map<ShowRoomBranchModel>((e) {
        return e;
      }).toList()) ;
      log("get Brands", _showRoomsBranchesResponse!.data!.toString());
    } else {
      if (kDebugMode) {
        print("Fail getBrands ${response.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
