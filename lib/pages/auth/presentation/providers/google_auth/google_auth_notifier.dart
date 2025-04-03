import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'google_auth_state.dart';

part 'google_auth_notifier.g.dart';

@riverpod
class GoogleAuthNotifier extends _$GoogleAuthNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  GoogleAuthState build() => GoogleAuthState();

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        state = state.copyWith(errorMessage: 'Sign-in cancelled');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Unexpected error: ${e.toString()}',
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // Added sign-out method
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _googleSignIn.signOut(); // Sign out from Google
      await _auth.signOut(); // Sign out from Firebase
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error signing out: ${e.toString()}',
        isLoading: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void _handleFirebaseError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'account-exists-with-different-credential':
        message = 'Account already exists with different credentials';
        break;
      case 'invalid-credential':
        message = 'Invalid credentials';
        break;
      case 'operation-not-allowed':
        message = 'Google sign-in is not enabled';
        break;
      default:
        message = 'Google sign-in failed: ${e.message}';
    }
    state = state.copyWith(errorMessage: message, isLoading: false);
  }
}