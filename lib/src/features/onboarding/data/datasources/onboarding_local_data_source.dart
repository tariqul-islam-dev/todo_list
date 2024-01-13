import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constants.dart';
import '../models/onboarding_model.dart';

abstract class OnboardingLocalDataSource {
  Future<OnboardingModel> getIsFirstTime();

  Future<bool> setIsFirstTime(OnboardingModel onboardingModel);
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences preferences;

  OnboardingLocalDataSourceImpl({required this.preferences});

  @override
  Future<OnboardingModel> getIsFirstTime() async {
    final String? jsonString = preferences.getString(Keys.onboardingKey);

    if (jsonString == null) {
      return OnboardingModel();
    }

    final decodedJson = jsonDecode(jsonString);
    return OnboardingModel.fromJson(decodedJson);
  }

  @override
  Future<bool> setIsFirstTime(OnboardingModel onboardingModel) async {
    final jsonString = jsonEncode(onboardingModel.toJson());
    return await preferences.setString(Keys.onboardingKey, jsonString);
  }
}
