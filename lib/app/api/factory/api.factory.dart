import 'package:task_manager/app/api/constants/api.constant.dart';
import 'package:task_manager/app/api/interface/irepository.interface.dart';
import 'package:task_manager/app/api/service/data.repository.dart';

class APIRepoFactory {
  static IAPIRepository instance(
      {String baseURL = "${ApiData.API_URL}/api/v1",
      Map<String, String>? authHeader}) {
    if (baseURL.startsWith(ApiData.API_URL)) {
      //main api
      return DataRepository(baseURL: baseURL, isMainApp: true);
    }
    return DataRepository(baseURL: baseURL, authHeader: authHeader);
  }
}
