

import '../../../core/resources/resources.dart';

class OnBoardingModel {
  final String image, title, subtitle;

  OnBoardingModel(
      {required this.image, required this.title, required this.subtitle});
}

final List<OnBoardingModel> onBoardingData = [

  OnBoardingModel(
      title: StringsManager.onBoarding3Title,
      subtitle: StringsManager.onBoarding3SubTitle,
      image: AssetsManager.onBoarding),
];
