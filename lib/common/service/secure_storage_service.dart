import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

@singleton
class SecureStorageService {
  // Название "коробки" (box) - аналог папки или таблицы
  static const String _boxName = 'secure_images';
  static const String _counterRequestSpicyApi = 'counter_request_spicyapi';
  static const String _counterRequestBanana = 'counter_request_banana';

  // Инициализация (вызвать 1 раз в main.dart)
  Future<void> init() async {
    // Эта строка магии:
    // На Mobile: находит правильную папку документов.
    // На Web: настраивает IndexedDB.
    await Hive.initFlutter();
    await Hive.openBox<int>(_counterRequestSpicyApi);
    await Hive.openBox<int>(_counterRequestBanana);
    if (kIsWeb) {
      await Hive.openBox<Uint8List>(_boxName);
    }
  }

  int getCountRequestSpicy() {
    final box = Hive.box<int>(_counterRequestSpicyApi);
    String dateKey =
        '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';

    return box.get(dateKey) ?? 0;
  }

  Future<int> addRequestSpicy() async {
    final box = Hive.box<int>(_counterRequestSpicyApi);
    String dateKey =
        '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';

    int count = box.get(dateKey) ?? 0;
    count = count + 1;
    await box.put(dateKey, count);
    return count;
  }

  int getCountRequestBanana() {
    final box = Hive.box<int>(_counterRequestBanana);
    String dateKey =
        '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';

    return box.get(dateKey) ?? 0;
  }

  Future<int> addRequestBanana() async {
    final box = Hive.box<int>(_counterRequestBanana);
    String dateKey =
        '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';

    int count = box.get(dateKey) ?? 0;
    count = count + 1;
    await box.put(dateKey, count);
    return count;
  }

  // 1. Сохранение (работает и на Web, и на Mobile)
  Future<void> saveImage(
    String modelId,
    String fileName,
    Uint8List imageBytes,
  ) async {
    var cropImageByte = await _cropImageSides(imageBytes, 85, 85);

    if (kIsWeb) {
      final box = Hive.box<Uint8List>(_boxName);
      // Сохраняем байты под именем файла

      await box.put(fileName, cropImageByte);
    } else {
      final path = await _localPath();
      final file = File('$path/$modelId/$fileName');

      // Создаем директорию, если она не существует
      final dir = Directory('$path/$modelId');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      // Записываем байты в файл
      await file.writeAsBytes(cropImageByte);
    }
  }

  // 2. Получение
  FutureOr<Uint8List?> getImage(String modelId, String fileName) async {
    if (kIsWeb) {
      final box = Hive.box<Uint8List>(_boxName);
      return box.get(fileName);
    } else {
      final path = await _localPath();
      final file = File('$path/$modelId/$fileName');

      if (await file.exists()) {
        var byteImage = await file.readAsBytes();
        return byteImage;
      } else {
        return null;
      }
    }
  }

  Future<String> getFullPath(String modelId) async {
    if (!kIsWeb) {
      final path = await _localPath();
      return '$path/$modelId';
    }
    return modelId;
  }

  // 3. Удаление (если нужно)
  Future<void> deleteImage(String fileName) async {
    if (kIsWeb) {
      final box = Hive.box<Uint8List>(_boxName);
      await box.delete(fileName);
    } else {
      final path = await _localPath();
      final file = File('$path/$fileName');
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  // Получаем путь к скрытой директории
  Future<String> _localPath() async {
    // getApplicationSupportDirectory - лучший выбор для скрытых файлов
    // getApplicationDocumentsDirectory - тоже подойдет, но на iOS содержимое этой папки
    // теоретически может быть доступно пользователю, если включен File Sharing.
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  Future<Uint8List> _cropImageSides(
    Uint8List imageBytes,
    int leftCrop,
    int rightCrop,
  ) async {
    // Декодируем изображение
    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception('Не удалось декодировать изображение');
    }

    // Проверяем, достаточно ли ширины для обрезки
    final originalWidth = originalImage.width;
    final originalHeight = originalImage.height;

    if (originalWidth <= leftCrop + rightCrop) {
      throw Exception('Ширина изображения слишком мала для обрезки');
    }

    // Вычисляем новые размеры
    final newWidth = originalWidth - leftCrop - rightCrop;
    final newHeight = originalHeight;

    // Создаем новое изображение для обрезанной версии
    img.Image croppedImage = img.Image(width: newWidth, height: newHeight);

    // Копируем пиксели (обрезаем слева и справа)
    for (int y = 0; y < newHeight; y++) {
      for (int x = 0; x < newWidth; x++) {
        final srcX = x + leftCrop;
        final srcY = y;

        final color = originalImage.getPixel(srcX, srcY);
        croppedImage.setPixel(x, y, color);
      }
    }

    // Кодируем обратно в JPEG или PNG
    //return Uint8List.fromList(img.encodeJpg(croppedImage));
    // Или для PNG:
    return Uint8List.fromList(img.encodePng(croppedImage));
  }

  Future<File> downloadImage({
    required String modelId,
    required String imageUrl,
    required String fileName,
  }) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to download image');
    }

    final path = await _localPath();
    final file = File('$path/$modelId/$fileName');

    // Создаем директорию, если она не существует
    final dir = Directory('$path/$modelId');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
