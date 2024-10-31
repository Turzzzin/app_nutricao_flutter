import 'package:image_picker/image_picker.dart';


Future<String> getPhoto() async {
  final ImagePicker _picker = ImagePicker();
  XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
  if (photo != null) {
    return photo.path;
  } else {
    return '';
  }
}