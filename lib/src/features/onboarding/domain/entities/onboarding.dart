import 'package:equatable/equatable.dart';

class Onboarding  extends Equatable{
  bool isFirstTime;

  Onboarding({this.isFirstTime = false});

  @override
  List<Object?> get props => [isFirstTime];
}