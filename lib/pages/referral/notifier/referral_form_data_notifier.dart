import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferralFormData {
  Map<String, String> step1Data = {};
  Map<String, String> step2Data = {};

  ReferralFormData({Map<String, String>? step1, Map<String, String>? step2}) {
    if (step1 != null) step1Data = step1;
    if (step2 != null) step2Data = step2;
  }

  ReferralFormData copyWith({
    Map<String, String>? step1Data,
    Map<String, String>? step2Data,
  }) {
    return ReferralFormData(
      step1: step1Data ?? this.step1Data,
      step2: step2Data ?? this.step2Data,
    );
  }
}

class ReferralFormNotifier extends StateNotifier<ReferralFormData> {
  ReferralFormNotifier() : super(ReferralFormData());

  void updateStep1(Map<String, String> data) {
    state = state.copyWith(step1Data: data);
  }

  void updateStep2(Map<String, String> data) {
    state = state.copyWith(step2Data: data);
  }

  void reset() {
    state = ReferralFormData();
  }
}

final referralFormProvider =
    StateNotifierProvider<ReferralFormNotifier, ReferralFormData>((ref) {
  return ReferralFormNotifier();
});