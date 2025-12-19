import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class StorageServices {
  final FirebaseStorage _firebaseStorage;
  StorageServices(FirebaseStorage firebaseStorage)
    : _firebaseStorage = firebaseStorage;

  // Получить список изображений
  Future<List<String>> getPhotoList(String modelId) async {
    final ListResult listResult = await _firebaseStorage
        .ref('$modelId/')
        .listAll();

    var list = listResult.items
        .where((el) => !el.name.contains('.keep'))
        .toList();

    var urlList = await Future.wait(list.map((ref) => ref.getDownloadURL()));
    return urlList;
  }

  Future<String> getAvatarMini(String modelId) async {
    final ListResult listResult = await _firebaseStorage
        .ref('$modelId/avatar_mini/')
        .listAll();

    var list = listResult.items
        .where((el) => !el.name.contains('.keep'))
        .toList();

    if (list.isNotEmpty) {
      var url = await list.first.getDownloadURL();
      return url;
    }

    return '';
  }

  Future<String> getAvatar(String modelId) async {
    final ListResult listResult = await _firebaseStorage
        .ref('$modelId/avatar/')
        .listAll();

    var list = listResult.items
        .where((el) => !el.name.contains('.keep'))
        .toList();

    if (list.isNotEmpty) {
      var url = await list.first.getDownloadURL();
      return url;
    }

    return '';
  }

  Future<Uint8List?> getAvatarByte(String modelId) async {
    final ListResult listResult = await _firebaseStorage
        .ref('$modelId/avatar/')
        .listAll();

    var list = listResult.items
        .where((el) => !el.name.contains('.keep'))
        .toList();

    if (list.isNotEmpty) {
      var url = await list.first.getData();
      return url;
    }

    final ListResult listAllResult = await _firebaseStorage
        .ref('$modelId/')
        .listAll();

    list = listAllResult.items
        .where((el) => !el.name.contains('.keep'))
        .toList();

    if (list.isNotEmpty) {
      var result = await list.first.getData();
      return result;
    }

    return null;
  }

  Future<String> getVideo(String modelId) async {
    final ListResult listResult = await _firebaseStorage
        .ref('$modelId/video/')
        .listAll();

    var list = listResult.items
        .where((el) => !el.name.contains('.keep'))
        .toList();

    if (list.isNotEmpty) {
      var url = await list.first.getDownloadURL();
      return url;
    }

    return '';
  }

  // Создать каталоги
  Future<void> createFolders() async {
    try {
      await Future.wait(
        List.generate(50, (index) async {
          String name = 'hotboy';
          if ((index + 1) < 10) {
            name = '${name}_0${index + 1}';
          } else {
            name = '${name}_${index + 1}';
          }
          String avatar = '$name/avatar/.keep';
          String avatarMini = '$name/avatar_mini/.keep';
          String video = '$name/video/.keep';

          final Reference folderModel = FirebaseStorage.instance.ref().child(
            '$name/.keep',
          );
          final Reference folderAvatarModel = FirebaseStorage.instance
              .ref()
              .child(avatar);
          final Reference folderAvatarMiniModel = FirebaseStorage.instance
              .ref()
              .child(avatarMini);
          final Reference folderVideoModel = FirebaseStorage.instance
              .ref()
              .child(video);
          // Загружаем пустой файл
          await folderModel.putString('');
          await folderAvatarModel.putString('');
          await folderAvatarMiniModel.putString('');
          await folderVideoModel.putString('');
          // ignore: avoid_print
          print('Папка $folderModel создана успешно');
        }),
      );
    } catch (e) {
      // ignore: avoid_print
      print('Ошибка при создании папки: $e');
    }
  }

  // Загрузить изображение

  // Удалить изображение
}
