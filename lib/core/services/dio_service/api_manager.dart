import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_network_config.dart';
import 'package:jobportals/core/constants/app_session.dart';
import 'package:jobportals/core/helpers/common_helper.dart';
import 'package:jobportals/core/helpers/storage_helper.dart';
import 'package:jobportals/core/services/dio_service/api_response.dart';
import 'package:jobportals/view/auth/auth_service.dart';

Dio dio = Dio();

enum ApiType { get, post, put, delete }

class ApiManager {
  Future get(String endpoint) async {
    try {
      log("Requesting to: $endpoint");
      dynamic response = await dio.get(endpoint);
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  ApiManager() {
    dio.options
      ..baseUrl = AppNetworkConfig.apiBaseURL
      ..validateStatus = (int? status) {
        return status! > 0;
      }
      ..headers = {'Accept': 'application/json', 'content-type': 'application/json'};
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) => handler.next(response),
        onError: (DioError e, handler) {
          if (kDebugMode) {
            print("interceptors onError : ${e.toString()}");
          }
          return handler.next(e);
        },
      ),
    );
  }

  // ignore: missing_return
  Future<APIResponse> call(String apiName, body, type) async {
    APIResponse apiData = APIResponse(message: 'No Data', data: null);
    try {
      bool isInternet = await commonHelper.isNetworkConnection();
      if (isInternet) {
        dynamic authToken = await getStorage(AppSession.token);
        if (authToken != null && authToken != '') {
          dio.options.headers["Authorization"] = "Bearer $authToken";
        } else {
          AuthService authService = Get.find();
          if (authService.verificationToken.value != "") {
            dio.options.headers["Authorization"] = "Bearer ${authService.verificationToken.value}";
          }
        }
        dynamic response;
        log("Bearer AuthToken...${dio.options.headers["Authorization"]}");
        log("Request...$body");
        log("Api...${AppNetworkConfig.apiBaseURL}$apiName");
        switch (type) {
          case ApiType.post:
            response = await dio.post(apiName, data: body);
            break;
          case ApiType.delete:
            response = await dio.delete(apiName, data: body);
            break;
          case ApiType.put:
            response = await dio.put(apiName, data: body);
            break;
        }
        log("Response...$response");
        apiData = await _checkStatus(response, apiName);
      } else {
        commonHelper.goToNoInternetScreen();
      }
      return apiData;
    } on DioError {
      return apiData;
    } on SocketException catch (e) {
      onSocketException(e);
      return apiData;
    } on Exception catch (e) {
      onException(e);
      return apiData;
    }
  }

  Future<APIResponse> _checkStatus(response, apiName) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return APIResponse(
        message: response.data['message'],
        data: response.data['data'],
      );
    } else if (response.statusCode == 422 || response.statusCode == 404) {
      return APIResponse(
        message: response.data['message'],
        data: response.data['data'],
      );
    } else if (response.statusCode == 401) {
      return APIResponse(
        message: response.data['message'],
        data: response.data['data'],
      );
    } else {
      return APIResponse(
        message: response.statusMessage,
        data: 0,
      );
    }
  }

  onSocketException(e) => log("API : SocketException - ${e.toString()}");

  onException(e) => log("API : Exception - ${e.toString()}");

}
