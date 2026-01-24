import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/usecases/upload_image_usecase.dart';
import '../datasources/image_remote_data_source.dart';

/// Firebase Storage implementation of ImageRepository
class FirebaseImageRepository implements ImageRepository {
  final ImageRemoteDataSource _remoteDataSource;

  FirebaseImageRepository({required ImageRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, String>> uploadImage(File image, String path) async {
    try {
      // Verify local file exists
      if (!await image.exists()) {
        return Left(
            DatabaseFailure(message: 'Local file not found at: ${image.path}'));
      }

      final downloadUrl = await _remoteDataSource.uploadImage(image, path);
      return Right(downloadUrl);
    } on DatabaseException catch (e) {
      String customMessage = 'Firebase Storage Error: [${e.code}] ${e.message}';
      if (e.code == 'object-not-found') {
        customMessage =
            'Storage bucket not found. Please ensure Firebase Storage is enabled in the Firebase Console and the bucket name is correct in firebase_options.dart. [${e.code}]';
      } else if (e.code == 'unauthorized') {
        customMessage =
            'Permission denied. Check your Firebase Storage rules. [${e.code}]';
      }
      return Left(DatabaseFailure(message: customMessage, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(
          message: 'Unexpected error during upload: ${e.toString()}'));
    }
  }
}
