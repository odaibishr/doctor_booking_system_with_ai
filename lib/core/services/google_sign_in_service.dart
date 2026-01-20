import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _googleSignIn.initialize();
      _isInitialized = true;
    }
  }

  Future<GoogleSignInResult?> signInWithGoogle() async {
    await _ensureInitialized();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final String? idToken = googleAuth.idToken;

    if (idToken == null) {
      throw Exception('Failed to get ID token from Google Sign-In');
    }

    final GoogleSignInClientAuthorization clientAuth = await googleUser
        .authorizationClient
        .authorizeScopes([]);
    final String accessToken = clientAuth.accessToken;

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

    return GoogleSignInResult(
      user: user,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOut() async {
    await _ensureInitialized();
    await _googleSignIn.signOut();
    await _auth.signOut();
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
