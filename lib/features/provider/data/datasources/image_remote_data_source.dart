import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';

abstract class ImageRemoteDataSource {
  Future<String> uploadImage(File image, String path);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final SupabaseClient _supabaseClient;
  // Bucket name must exist in Supabase Storage
  static const String _bucketName = 'khadamaty-bucket';

  ImageRemoteDataSourceImpl({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  @override
  Future<String> uploadImage(File image, String path) async {
    try {
      final fileExt = path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath =
          'public/$fileName'; // Path inside the bucket matching RLS policy

      await _supabaseClient.storage.from(_bucketName).upload(
            filePath,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final imageUrl =
          _supabaseClient.storage.from(_bucketName).getPublicUrl(filePath);

      return imageUrl;
    } on StorageException catch (e) {
      throw DatabaseException(e.message, e.statusCode ?? 'storage-error');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
