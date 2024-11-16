import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:task_manager/app/api/constants/api.constant.dart';

import 'package:http/http.dart' as http;

import 'dart:developer';

import 'package:task_manager/app/api/interface/irepository.interface.dart';

class DataRepository implements IAPIRepository {
  final String baseURL;
  final int tryCountOnConnBrokeException = 5;
  final Map<String, String>? authHeader;
  final bool isMainApp;

  static String userAccessToken = "";

  DataRepository(
      {this.baseURL = "${ApiData.API_URL}/api",
      this.authHeader,
      this.isMainApp = false});

  @override
  getData(String endpoint,
      {String? useThisUrl,
      Map<String, dynamic>? otherHeaders,
      int tryCount = 0}) async {
    try {
      String url = "${useThisUrl ?? baseURL}/$endpoint";

      log(">>Gettting the data.");
      log(url);

      DateTime rt = DateTime.now();

      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        ...?authHeader,
        if (otherHeaders != null) ...otherHeaders
      });

      if (kDebugMode) {
        log(">>ResposneStatus: ${response.statusCode}");
        log(">>ResponseData");
        log(response.body);
        log("##Total time of request: ${DateTime.now().difference(rt).inMilliseconds}ms");
      }
      dynamic responseData;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        responseData = jsonDecode(response.body);
      }
      return responseData;
    } catch (e) {
      log(e.toString());
      //
    }
  }

  @override
  postData(String endpoint, Map<String, dynamic> data,
      {String? useThisUrl,
      Map<String, dynamic>? otherHeaders,
      int tryCount = 0}) async {
    try {
      String url = "${useThisUrl ?? baseURL}/$endpoint";
      DateTime rt = DateTime.now();

      if (kDebugMode) {
        log(">>ENDPOINT: $endpoint");
        log(">>BODY DATA");
        log(jsonEncode(data));
      }

      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            ...data,
          }),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            ...?authHeader,
            if (isMainApp && userAccessToken.isNotEmpty)
              "Authorization": "Bearer $userAccessToken",
            if (otherHeaders != null) ...otherHeaders
          },
          encoding: Encoding.getByName('utf-8'));

      if (kDebugMode) {
        log(">>Response Status: ${response.statusCode.toString()}");
        log(">>Response Body");
        log(response.body);
        print(
            "##Total time of request: ${DateTime.now().difference(rt).inMilliseconds}ms");
      }

      dynamic responseData = jsonDecode(response.body);

      return responseData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  updateData(String endpoint, Map<String, dynamic> data,
      {String? useThisUrl,
      Map<String, dynamic>? otherHeaders,
      int tryCount = 0}) async {
    try {
      String url = "${useThisUrl ?? baseURL}/$endpoint";
      DateTime rt = DateTime.now();

      if (kDebugMode) {
        log(">>ENDPOINT: $endpoint");
        log(">>BODY DATA");
        log(jsonEncode(data));
      }

      var response = await http.patch(Uri.parse(url),
          body: jsonEncode({
            ...data,
          }),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            ...?authHeader,
            if (isMainApp && userAccessToken.isNotEmpty)
              "Authorization": "Bearer $userAccessToken",
            if (otherHeaders != null) ...otherHeaders
          },
          encoding: Encoding.getByName('utf-8'));

      if (kDebugMode) {
        log(">>Response Status: ${response.statusCode.toString()}");
        log(">>Response Body");
        log(response.body);
        print(
            "##Total time of request: ${DateTime.now().difference(rt).inMilliseconds}ms");
      }

      dynamic responseData = jsonDecode(response.body);

      return responseData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  deleteData(String endpoint, Map<String, dynamic> data,
      {String? useThisUrl,
      Map<String, dynamic>? otherHeaders,
      int tryCount = 0}) async {
    try {
      String url = "${useThisUrl ?? baseURL}/$endpoint";
      var response = await http.delete(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            ...?authHeader,
            if (isMainApp && userAccessToken.isNotEmpty)
              "Authorization": "Bearer $userAccessToken",
            if (otherHeaders != null) ...otherHeaders
          },
          encoding: Encoding.getByName('utf-8'));

      dynamic responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Uint8List> getFile(String url,
      {String? useThisUrl,
      Map<String, dynamic>? otherHeaders,
      int tryCount = 0}) async {
    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        ...?authHeader,
        ...?otherHeaders
      });
      debugPrint(response.statusCode.toString());
      debugPrint("${response.bodyBytes.length} bytes");
      return response.bodyBytes;
    } catch (e) {
      rethrow;
    }
  }
}
