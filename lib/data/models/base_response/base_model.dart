import 'package:automobile_project/data/models/base_response/pagination_model.dart';

class BaseModel<E> {
  int? code;
  bool? status;
  String? message;
  E? data;
  PaginationModel? pagination;

  BaseModel({this.code, this.status, this.message, this.data, this.pagination});

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        code: json['code'],
        status: json['status'],
        message: json['message'],
        data: json['data'],
        pagination: PaginationModel.fromJson(json['pagination']),
      );
}
