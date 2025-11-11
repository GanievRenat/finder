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
    var urlList = await Future.wait(
      listResult.items.map((ref) => ref.getDownloadURL()),
    );
    return urlList;
  }
  // Загрузить изображение

  // Удалить изображение
}
