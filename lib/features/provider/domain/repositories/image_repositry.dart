

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/core/error/failures.dart';

abstract class ImageRepository {
  Future<Either<Failure, String>> uploadImage(File image, String path);
}
