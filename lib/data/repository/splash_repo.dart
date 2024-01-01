
import 'package:elaser/data/data_source/remote/dio/dio_client.dart';
import 'package:elaser/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  SplashRepo({
    required this.dioClient,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  final DioClient dioClient;

  bool isFirstOpen() {
    return sharedPreferences.getBool(AppConstants.FIRST_OPEN) ?? true;
  }

//   Future<ApiResponse> getConfig({
//     bool user = false,
//     bool countries = false,
//     bool areas = false,
//     bool categories = false,
//     bool banners = false,
// }) async {
//     try {
//       final response = await dioClient.get(
//         AppConstants.CONFIG,
//         queryParameters: {
//           'app_uid': '${Platform.isAndroid?'android':'ios'}.user',
//           "preload[]": '', // required, until if no data was passed
//           if(user)"preload[]": 'user',
//           if(countries)"preload[]": 'countries',
//           if(areas)"preload[]": 'areas',
//           if(categories)"preload[]": 'categories',
//           if(banners)"preload[]": 'banners',
//         },
//       );
//       return ApiResponse.fromResponse(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.handle(e));
//     }
//   }

  Future<bool> setIsAppFirstOpen([bool value = false]) async {
    return await sharedPreferences.setBool(AppConstants.FIRST_OPEN, value);
  }
}
