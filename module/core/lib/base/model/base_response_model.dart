import 'package:json_annotation/json_annotation.dart';
part 'base_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseResponseModel {
  BaseResponseModel({
    this.data,
    this.messages,
    this.status,
    this.success,
  });

  dynamic data;
  List<String>? messages;
  int? status;
  bool? success;

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return _$BaseResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BaseResponseModelToJson(this);
  }
}
