import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitas_clone/pages/referral/notifier/referral_form_data_notifier.dart';

// Define the state for sending referral
class ReferralState {
  final bool isLoading;
  final bool isSuccessful;
  final String? errorMessage;

  ReferralState({
    required this.isLoading,
    required this.isSuccessful,
    this.errorMessage,
  });

  ReferralState.initial()
      : isLoading = true,
        isSuccessful = false,
        errorMessage = null;

  ReferralState.success()
      : isLoading = false,
        isSuccessful = true,
        errorMessage = null;

  ReferralState.error(String errorMessage)
      : isLoading = false,
        isSuccessful = false,
        errorMessage = errorMessage;
}

// Define a StateNotifier to handle referral sending logic
class ReferralNotifier extends StateNotifier<ReferralState> {
  ReferralNotifier() : super(ReferralState.initial());

  Future<void> sendReferral(Map <String,String> referralData) async {
    try {
      state = ReferralState.initial(); // Start loading
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final FirebaseAuth auth = FirebaseAuth.instance;

      final String? uid = auth.currentUser?.uid;

      if (uid == null) {
        throw Exception("User not logged in");
      }

      // Replace with the actual collection and data
      await firestore.collection('referrals').add({
         ...referralData,
        'uid':uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      state = ReferralState.success(); 
     // Referral sent successfully
    } catch (e) {
      state = ReferralState.error('Failed to send referral: $e'); // Error state
    }
  }
}

// Create a provider for the ReferralNotifier
final referralProvider = StateNotifierProvider<ReferralNotifier, ReferralState>((ref) {
  return ReferralNotifier();
});