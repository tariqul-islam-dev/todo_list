import '../../domain/entities/onboarding.dart';

class OnboardingModel extends Onboarding {
  OnboardingModel({
    bool isFirstTime = false,
  }) : super(isFirstTime: isFirstTime);

  OnboardingModel.fromJson(dynamic json) {
    isFirstTime = json['isFirstTime'];
  }

  OnboardingModel.fromObject({required Onboarding onboarding}) {
    isFirstTime = onboarding.isFirstTime;
  }

  OnboardingModel copyWith({
    bool isFirstTime = false,
  }) =>
      OnboardingModel(
        isFirstTime: isFirstTime,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isFirstTime'] = isFirstTime;
    return map;
  }
}
