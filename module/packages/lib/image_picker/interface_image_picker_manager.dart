import 'package:image_picker/image_picker.dart';

abstract class IImagePickerManager {
  init();
  Future<String?> pickImageCamera();
  Future<String?> pickImageGallery();
}
