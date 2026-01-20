import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<GoogleSignInResult?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        log('Google Sign-In: User cancelled');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // In v6.x, accessToken is always present in the authentication object
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw Exception('Failed to get ID token from Google Sign-In');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to sign in with Firebase');
      }

      log('Google Sign-In successful for: ${user.email}');

      return GoogleSignInResult(
        user: user,
        idToken: idToken,
        accessToken: accessToken ?? '',
      );
    } catch (e) {
      if (e.toString().contains("PlatformException")) {
        log("🔴 GOOGLE SIGN-IN PLATFORM EXCEPTION 🔴");
        log("Error: $e");
        // Check console for things like 'sign_in_failed' or code '10'
      }
      log('Google Sign-In error details: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      log("Error during logout: $e");
    }
  }
}

class GoogleSignInResult {
  final User user;
  final String idToken;
  final String accessToken;

  GoogleSignInResult({
    required this.user,
    required this.idToken,
    required this.accessToken,
  });
}
