import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/save_role_usecase.dart';
import 'package:automobile_project/domain/use_case/show_rooms/show_room_branches_use_case.dart';
import 'package:flutter/material.dart';



class ShowRoomLoginViewModel extends ChangeNotifier {
  final ShowRoomsBranchesUseCase _showRoomsBranchesUseCase;


  ShowRoomLoginViewModel(
      {required ShowRoomsBranchesUseCase showRoomsBranchesUseCase,
        })
      : _showRoomsBranchesUseCase = showRoomsBranchesUseCase
        ;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel<List<ShowRoomBranchModel>>> getMyBranches({
    required BuildContext context,
    required String code,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _showRoomsBranchesUseCase.call(
      context: context,
      id: 1

    );
    print(responseModel.data);
    if (responseModel.isSuccess) {


      print("success view Model data ${responseModel.data}");

    } else {
      print("Fail view Model ${responseModel.message}");
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }



  Future<ResponseModel<List<ShowRoomBranchModel>>> getMyBranchesById({
    required BuildContext context,
    required int id,

  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _showRoomsBranchesUseCase.callById(
    id: id ,
      context: context

    );
    print(responseModel.data);
    if (responseModel.isSuccess) {


      print("success view Model data ${responseModel.data}");

    } else {
      print("Fail view Model ${responseModel.message}");
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
