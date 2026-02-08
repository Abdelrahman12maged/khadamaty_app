import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/features/provider/domain/repositories/image_repositry.dart';
import '../../../../core/error/failures.dart';

/// UseCase to upload an image to storage
class UploadImageUseCase {
  final ImageRepository _repository;

  UploadImageUseCase(this._repository);

  Future<Either<Failure, String>> call(File image, String path) async {
    return await _repository.uploadImage(image, path);
  }
}

/// Simple repository interface for image operations
