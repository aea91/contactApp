import 'package:image_picker/image_picker.dart';
import 'package:packages/image_picker/interface_image_picker_manager.dart';

class ImagePickerManager implements IImagePickerManager {
  // singleton lazy pattern
  ImagePicker? _imagePicker;
  static ImagePickerManager? _instance;
  ImagePickerManager._init();

  static ImagePickerManager? get instance {
    _instance ??= ImagePickerManager._init();
    return _instance;
  }

  @override
  init() {
    _imagePicker = ImagePicker();
  }

  @override
  Future<String?> pickImageCamera() async {
    XFile? file = await _imagePicker!.pickImage(source: ImageSource.camera);
    return file?.path;
  }

  @override
  Future<String?> pickImageGallery() async {
    XFile? file = await _imagePicker!.pickImage(source: ImageSource.gallery);
    return file?.path;
  }
}
