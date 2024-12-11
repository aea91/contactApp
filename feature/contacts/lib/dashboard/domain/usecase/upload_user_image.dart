import 'package:contacts/dashboard/domain/entity/upload_image_dto_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';

class UploadUserImageUseCase
    extends UseCaseWithParams<UploadImageDtoEntity, UploadUserImageParams> {
  UploadUserImageUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<UploadImageDtoEntity> call(UploadUserImageParams params) =>
      _repository.uploadImage(image: params.image);
}

class UploadUserImageParams {
  final List<int> image;

  UploadUserImageParams({required this.image});
}
