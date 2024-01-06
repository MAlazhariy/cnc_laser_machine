
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

  String? getIpAddress (){
    return sharedPreferences.getString(AppConstants.IP_ADDRESS);
  }

  String? getPort (){
    return sharedPreferences.getString(AppConstants.PORT) ?? AppConstants.defaultGRBLPort;
  }


  Future<void> saveConfigData (String ipAddress, String port) async {
    await Future.wait([
      sharedPreferences.setString(AppConstants.IP_ADDRESS, ipAddress),
      sharedPreferences.setString(AppConstants.PORT, port),
    ]);
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
}
