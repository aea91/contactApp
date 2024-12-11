import 'package:contacts/dashboard/domain/entity/upload_image_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_image_model.g.dart';

@JsonSerializable()
class UploadImageModel extends UploadImageDtoEntity {
  UploadImageModel({required super.imageUrl});

  factory UploadImageModel.fromJson(Map<String, dynamic> json) => _$UploadImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageModelToJson(this);

  UploadImageDtoEntity toEntity() => UploadImageDtoEntity(imageUrl: imageUrl);
}
