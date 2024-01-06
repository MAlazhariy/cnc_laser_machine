import 'package:elaser/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;

  SplashProvider({
    required this.splashRepo,
  });

  bool _isLoading = false;
  String? _ipAddress;
  String? _port;

  bool get isLoading => _isLoading;

  String? get ipAddress => _ipAddress;

  String? get port => _port;

  /// Check if the [ipAddress] & [port] have data.
  bool get hasConnectionData => _port != null && _ipAddress != null;

  bool getConfig() {
    _ipAddress = splashRepo.getIpAddress();
    _port = splashRepo.getPort();

    notifyListeners();
    return hasConnectionData;
  }

  Future<void> saveConfigData({
    required String ipAddress,
    required String port,
}) async {
    _isLoading = true;
    notifyListeners();

    _ipAddress = _ipAddress;
    _port = port;

    await splashRepo.saveConfigData(ipAddress, port);
    _isLoading = false;
    notifyListeners();
  }

// Future<ResponseModel> getConfig({
//   bool user = false,
//   bool countries = false,
//   bool areas = false,
//   bool categories = false,
//   bool banners = false,
// }) async {
//   _isLoading = true;
//   notifyListeners();
//
//   final apiResponse = await splashRepo.getConfig(
//     user: user,
//     countries: countries,
//     areas: areas,
//     categories: categories,
//     banners: banners,
//   );
//   late ResponseModel responseModel;
//
//   if(apiResponse.isSuccess){
//     responseModel = ResponseModel.withSuccess();
//   } else {
//     responseModel = ResponseModel.withError(apiResponse.error?.message);
//   }
//
//   _isLoading = false;
//   notifyListeners();
//   return responseModel;
// }
}
