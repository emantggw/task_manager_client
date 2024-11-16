import 'dart:typed_data';

abstract class IAPIRepository {
  Future<dynamic> getData(String endpoint,
      {String? useThisUrl, Map<String, dynamic>? otherHeaders});
  Future<Uint8List> getFile(String endpoint,
      {String? useThisUrl, Map<String, dynamic>? otherHeaders});
  Future<dynamic> postData(String endpoint, Map<String, dynamic> data,
      {String? useThisUrl, Map<String, dynamic>? otherHeaders});
  Future<dynamic> updateData(String endpoint, Map<String, dynamic> data,
      {String? useThisUrl, Map<String, dynamic>? otherHeaders});
  Future<dynamic> deleteData(String endpoint, Map<String, dynamic> data,
      {String? useThisUrl, Map<String, dynamic>? otherHeaders});
}
