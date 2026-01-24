import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../core/error/exceptions.dart';

abstract class ImageRemoteDataSource {
  Future<String> uploadImage(File image, String path);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final FirebaseStorage _storage;

  ImageRemoteDataSourceImpl({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<String> uploadImage(File image, String path) async {
    try {
      final ref = _storage.ref().child(path);

      final uploadTask = ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        return await snapshot.ref.getDownloadURL();
      } else {
        throw DatabaseException(
            'Upload failed with state: ${snapshot.state}', 'storage-error');
      }
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'Storage error', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
