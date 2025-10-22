import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

/// Supabase Storage Service for file uploads and management
class SupabaseStorageService {
  final _storage = SupabaseConfig.storage;

  /// Upload profile picture
  /// Returns the public URL of the uploaded image
  Future<String> uploadProfilePicture(String userId, File file) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '$userId/$fileName';

      await _storage.from(SupabaseConfig.profilePicturesBucket).upload(
        path,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true, // Replace if exists
        ),
      );

      // Get public URL
      final url = _storage
          .from(SupabaseConfig.profilePicturesBucket)
          .getPublicUrl(path);
      
      return url;
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  /// Upload medical document (private)
  /// Returns a signed URL (expires in 1 hour)
  Future<String> uploadMedicalDocument({
    required String userId,
    required File file,
    required String fileName,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '$userId/$timestamp\_$fileName';

      await _storage.from(SupabaseConfig.medicalDocumentsBucket).upload(
        path,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: false,
        ),
      );

      // Get signed URL (private, expires in 1 hour)
      final url = await _storage
          .from(SupabaseConfig.medicalDocumentsBucket)
          .createSignedUrl(path, 3600); // 1 hour

      return url;
    } catch (e) {
      throw Exception('Failed to upload medical document: $e');
    }
  }

  /// Upload scan image
  Future<String> uploadScanImage({
    required String userId,
    required File file,
    String? customFileName,
  }) async {
    try {
      final fileName = customFileName ??
          'scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '$userId/$fileName';

      await _storage.from(SupabaseConfig.scanImagesBucket).upload(
        path,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: false,
        ),
      );

      final url = await _storage
          .from(SupabaseConfig.scanImagesBucket)
          .createSignedUrl(path, 86400); // 24 hours

      return url;
    } catch (e) {
      throw Exception('Failed to upload scan image: $e');
    }
  }

  /// Upload report (PDF)
  Future<String> uploadReport({
    required String userId,
    required File file,
    required String fileName,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '$userId/$timestamp\_$fileName';

      await _storage.from(SupabaseConfig.reportsBucket).upload(
        path,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: false,
          contentType: 'application/pdf',
        ),
      );

      final url = await _storage
          .from(SupabaseConfig.reportsBucket)
          .createSignedUrl(path, 604800); // 7 days

      return url;
    } catch (e) {
      throw Exception('Failed to upload report: $e');
    }
  }

  /// Delete file from storage
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      await _storage.from(bucket).remove([path]);
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  /// List user files in a bucket
  Future<List<FileObject>> listUserFiles({
    required String userId,
    required String bucket,
  }) async {
    try {
      final files = await _storage.from(bucket).list(path: userId);
      return files;
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }

  /// Get file URL (public or signed)
  Future<String> getFileUrl({
    required String bucket,
    required String path,
    bool isPublic = false,
    int expiresIn = 3600, // 1 hour default
  }) async {
    try {
      if (isPublic) {
        return _storage.from(bucket).getPublicUrl(path);
      } else {
        return await _storage.from(bucket).createSignedUrl(path, expiresIn);
      }
    } catch (e) {
      throw Exception('Failed to get file URL: $e');
    }
  }

  /// Download file
  Future<Uint8List> downloadFile({
    required String bucket,
    required String path,
  }) async {
    try {
      final bytes = await _storage.from(bucket).download(path);
      return bytes;
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }

  /// Update profile picture (delete old, upload new)
  Future<String> updateProfilePicture({
    required String userId,
    required File newFile,
    String? oldFilePath,
  }) async {
    try {
      // Delete old picture if exists
      if (oldFilePath != null) {
        try {
          await deleteFile(
            bucket: SupabaseConfig.profilePicturesBucket,
            path: oldFilePath,
          );
        } catch (e) {
          // Ignore if file doesn't exist
          print('Old profile picture not found: $e');
        }
      }

      // Upload new picture
      return await uploadProfilePicture(userId, newFile);
    } catch (e) {
      throw Exception('Failed to update profile picture: $e');
    }
  }
}
