
import 'package:elaser/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;

  SplashProvider({
    required this.splashRepo,
  });

  bool _isLoading = false;


  bool get isFirstOpen => splashRepo.isFirstOpen();
  bool get isLoading => _isLoading;

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

  Future<bool> setIsAppFirstOpen() async {
    return await splashRepo.setIsAppFirstOpen();
  }
}