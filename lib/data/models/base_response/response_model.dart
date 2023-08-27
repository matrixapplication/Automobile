import 'package:automobile_project/data/models/base_response/pagination_model.dart';

class ResponseModel<T> {
  final bool _isSuccess;
  final String? _message;
  final String? _error;
  T? data;
  final PaginationModel? pagination;

  ResponseModel(
    this._isSuccess,
    this._message, {
    this.data,
    this.pagination,
    String? error,
  }) : _error = error;

  String? get message => _message;

  String? get error => _error;

  bool get isSuccess => _isSuccess;
// dynamic get data => data;
}
