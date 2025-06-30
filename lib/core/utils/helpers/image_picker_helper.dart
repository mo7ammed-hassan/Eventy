import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile == null) return null;

      return pickedFile.path.replaceAll(' ', '-');
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Image Selection Error',
        message: 'Failed to select image: ${e.toString()}',
      );
      return null;
    }
  }
}
