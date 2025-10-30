import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@singleton
class PhotoPickerService {
  final ImagePicker _picker = ImagePicker();

  // Получить фото из галереи
  Future<File?> pickImageFromGallery() async {
    // Запрос разрешений
    //if (await _requestPermissions()) {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );

    if (image != null) {
      return await _saveImageToAppDirectory(File(image.path));
    }
    //}
    return null;
  }

  // Получить фото с камеры
  Future<File?> takePhotoWithCamera() async {
    // Запрос разрешений
    //if (await _requestPermissions()) {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );

    if (image != null) {
      return await _saveImageToAppDirectory(File(image.path));
    }
    //}
    return null;
  }

  // Сохранение в локальную директорию приложения
  Future<File> _saveImageToAppDirectory(File imageFile) async {
    // Получаем директорию приложения
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;

    // Создаем папку для изображений если ее нет
    final Directory imagesDir = Directory('$appDirPath/profile_images');
    if (!imagesDir.existsSync()) {
      imagesDir.createSync(recursive: true);
    }

    // Генерируем уникальное имя файла
    final String fileName =
        'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final String newPath = '${imagesDir.path}/$fileName';

    // Копируем файл в новую локацию
    return await imageFile.copy(newPath);
  }

  // Удалить сохраненное фото
  Future<void> deleteImage(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
