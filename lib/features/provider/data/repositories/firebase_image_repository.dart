import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/upload_image_usecase.dart';

/// Firebase Storage implementation of ImageRepository
class FirebaseImageRepository implements ImageRepository {
  final FirebaseStorage _storage;

  FirebaseImageRepository({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<Either<Failure, String>> uploadImage(File image, String path) async {
    try {
      // Verify local file exists
      if (!await image.exists()) {
        return Left(
            DatabaseFailure(message: 'Local file not found at: ${image.path}'));
      }

      final ref = _storage.ref().child(path);
      debugPrint('DEBUG: Attempting upload to bucket: ${_storage.bucket}');
      debugPrint('DEBUG: Full path: ${ref.fullPath}');

      // Start upload task
      final uploadTask = ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Wait for completion
      final snapshot = await uploadTask;

      // Handle success
      if (snapshot.state == TaskState.success) {
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return Right(downloadUrl);
      } else {
        return Left(DatabaseFailure(
          message: 'Upload failed with state: ${snapshot.state}',
        ));
      }
    } on FirebaseException catch (e) {
      // [firebase_storage/object-not-found] often means bucket not found or configuration error
      String customMessage = 'Firebase Storage Error: [${e.code}] ${e.message}';
      if (e.code == 'object-not-found') {
        customMessage =
            'Storage bucket not found. Please ensure Firebase Storage is enabled in the Firebase Console and the bucket name is correct in firebase_options.dart. [${e.code}]';
      } else if (e.code == 'unauthorized') {
        customMessage =
            'Permission denied. Check your Firebase Storage rules. [${e.code}]';
      }

      return Left(DatabaseFailure(message: customMessage));
    } catch (e) {
      return Left(DatabaseFailure(
          message: 'Unexpected error during upload: ${e.toString()}'));
    }
  }
}
