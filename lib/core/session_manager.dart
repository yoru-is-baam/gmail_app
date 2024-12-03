import 'package:firebase_auth/firebase_auth.dart';

class SessionManager {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static bool get isUserLoggedIn => _auth.currentUser != null;

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // static String? get currentUserId => _auth.currentUser?.uid;
  static String? get currentUserId => "123";

  static String? get currentEmail => "yoruisbaam@gmail.com";

  static Future<String?> getFreshIdToken() async {
    try {
      return await _auth.currentUser?.getIdToken(true); // true forces refresh
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
