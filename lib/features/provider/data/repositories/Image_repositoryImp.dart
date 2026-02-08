import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/features/provider/data/datasources/image_remote_data_source.dart';
import 'package:khadamaty_app/features/provider/domain/repositories/image_repositry.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/usecases/upload_image_usecase.dart';

/// Firebase Storage implementation of ImageRepository
class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource _remoteDataSource;

  ImageRepositoryImpl({required ImageRemoteDataSource remoteDataSource})
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
      // Pass through database/storage exceptions regardless of provider
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(
          message: 'Unexpected error during upload: ${e.toString()}'));
    }
  }
}
